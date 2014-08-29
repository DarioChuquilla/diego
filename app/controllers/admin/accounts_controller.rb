 class Admin::AccountsController < Admin::BaseController
  # load_and_authorize_resource

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /accounts/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_account_path(@user), notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def change_password
    @user = User.find(params[:id])
    if @user.id != current_user.id
      abort('User is not authorized')
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end

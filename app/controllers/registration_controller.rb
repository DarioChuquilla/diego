class RegistrationController < Devise::RegistrationsController

  def new

    @user= User.new
    @hotel = Hotel.new
  end

  def create

    @user = User.new
    @user.username = params[:user][:username]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation =params[:user][:password_confirmation]

    @hotel = Hotel.new
    @hotel.name = params[:hotel][:name]
    @hotel.description = params[:hotel][:description]
    @user.valid?
    if @user.errors.blank?
      @user.save
      @hotel.user = @user
      @hotel.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end

end
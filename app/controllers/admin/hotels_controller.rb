class Admin::HotelsController < Admin::BaseController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /hotels
  # GET /hotels.json
  def index
    @admin = false
    if current_user.role == 'admin'
      @hotels = Hotel.order(:name)
      @admin = true
    else
      @hotels = Hotel.order(:name).find_all_by_user_id current_user.id
      @admin = false
    end
    # authorize! :read, @hotels
    respond_to do |format|
      format.html and return # index.html.erb
      format.json { render json: @hotels } and return
    end
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
    @hotel = Hotel.find(params[:id])
    respond_to do |format|
      format.html and return # show.html.erb
      format.json { render json: @hotel } and return
    end
  end

  # GET /hotels/new
  # GET /hotels/new.json
  def new
    @hotel = Hotel.new
    respond_to do |format|
      format.html and return # new.html.erb
      format.json { render json: @hotel } and return
    end
  end

  # GET /hotels/1/edit
  def edit
    @hotel = Hotel.find(params[:id])
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(params[:hotel])
    @hotel.user = current_user

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to admin_hotels_path, notice: 'Hotel was successfully created.' }
        format.json { render json: @hotel, status: :created, location: @hotel }
      else
        format.html { render action: "new" }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hotels/1
  # PUT /hotels/1.json
  def update
    @hotel = Hotel.find(params[:id])
    respond_to do |format|
      if @hotel.update_attributes(params[:hotel])
        format.html { redirect_to admin_hotel_path(@hotel), notice: 'Hotel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to admin_hotels_url }
      format.json { head :no_content }
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def toggle_active
    @hotel = Hotel.find(params[:id])
    @hotel.toggle :active
    @hotel.save
    respond_to do |format|
      format.html { redirect_to admin_hotels_url }
      format.json { head :no_content }
    end
  end

  private

  def authorizations
    begin
      @hotel = Hotel.find(params[:id])
      authorize! :manage, @hotel
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end

end

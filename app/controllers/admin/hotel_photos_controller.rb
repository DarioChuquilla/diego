class Admin::HotelPhotosController < Admin::BaseController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /hotel_photos
  # GET /hotel_photos.json
  def index
    get_hotel
    @hotel_photos = HotelPhoto.find_all_by_hotel_id params[:hotel_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hotel_photos }
    end
  end

  # GET /hotel_photos/1
  # GET /hotel_photos/1.json
  def show
    get_hotel
    @hotel_photo = HotelPhoto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hotel_photo }
    end
  end

  # GET /hotel_photos/new
  # GET /hotel_photos/new.json
  def new
    get_hotel
    @hotel_photo = HotelPhoto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hotel_photo }
    end
  end

  # GET /hotel_photos/1/edit
  def edit
    get_hotel
    @hotel_photo = HotelPhoto.find(params[:id])
  end

  # POST /hotel_photos
  # POST /hotel_photos.json
  def create
    get_hotel
    @hotel_photo = HotelPhoto.new(params[:hotel_photo])
    @hotel_photo.hotel_id = params[:hotel_id]
    respond_to do |format|
      if @hotel_photo.save
        format.html { redirect_to admin_hotel_photos_url, notice: 'Hotel photo was successfully created.' }
        format.json { render json: @hotel_photo, status: :created, location: @hotel_photo }
      else
        format.html { render action: "new" }
        format.json { render json: @hotel_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hotel_photos/1
  # PUT /hotel_photos/1.json
  def update
    get_hotel
    @hotel_photo = HotelPhoto.find(params[:id])

    respond_to do |format|
      if @hotel_photo.update_attributes(params[:hotel_photo])
        format.html { redirect_to admin_hotel_photo_path(params[:hotel_id], @hotel_photo), notice: 'Hotel photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hotel_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotel_photos/1
  # DELETE /hotel_photos/1.json
  def destroy
    get_hotel
    @hotel_photo = HotelPhoto.find(params[:id])
    @hotel_photo.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotel_photos_url }
      format.json { head :no_content }
    end
  end

  private

  def authorizations
    begin
      @hotel_photo = HotelPhoto.find(params[:id])
      authorize! :manage, @hotel_photo
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end

end

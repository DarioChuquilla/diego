class Admin::RoomPhotosController < Admin::BaseController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /room_photos
  # GET /room_photos.json
  def index
    get_hotel
    get_room
    @room_photos = RoomPhoto.find_all_by_room_id params[:room_id]

    respond_to do |format|
      format.html and return # index.html.erb
      format.json { render json: @room_photos } and return
    end
  end

  # GET /room_photos/1
  # GET /room_photos/1.json
  def show
    get_hotel
    get_room
    @room_photo = RoomPhoto.find(params[:id])

    respond_to do |format|
      format.html and return # show.html.erb
      format.json { render json: @room_photo } and return
    end
  end

  # GET /room_photos/new
  # GET /room_photos/new.json
  def new
    get_hotel
    get_room
    @room_photo = RoomPhoto.new

    respond_to do |format|
      format.html and return # new.html.erb
      format.json { render json: @room_photo } and return
    end
  end

  # GET /room_photos/1/edit
  def edit
    get_hotel
    get_room
    @room_photo = RoomPhoto.find(params[:id])
  end

  # POST /room_photos
  # POST /room_photos.json
  def create
    get_hotel
    get_room
    @room_photo = RoomPhoto.new(params[:room_photo])
    @room_photo.room = @room

    respond_to do |format|
      if @room_photo.save
        format.html { redirect_to admin_hotel_room_photos_path(@hotel.id, @room.id), notice: 'Room photo was successfully created.' }
        format.json { render json: @room_photo, status: :created, location: @room_photo }
      else
        format.html { render action: "new" }
        format.json { render json: @room_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /room_photos/1
  # PUT /room_photos/1.json
  def update
    get_hotel
    get_room
    @room_photo = RoomPhoto.find(params[:id])

    respond_to do |format|
      if @room_photo.update_attributes(params[:room_photo])
        format.html { redirect_to admin_hotel_room_photos_path(@hotel.id, @room.id), notice: 'Room photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_photos/1
  # DELETE /room_photos/1.json
  def destroy
    get_hotel
    get_room
    @room_photo = RoomPhoto.find(params[:id])
    @room_photo.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotel_room_photos_path(@hotel, @room) }
      format.json { head :no_content }
    end
  end

  private

  def authorizations
    begin
      @room_photo = RoomPhoto.find(params[:id])
      authorize! :manage, @room_photo
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end

end

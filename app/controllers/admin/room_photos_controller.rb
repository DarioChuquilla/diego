class Admin::RoomPhotosController < Admin::BaseController
  # GET /room_photos
  # GET /room_photos.json
  def index
    @room_photos = RoomPhoto.find_all_by_room_id params[:room_id]
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @room_photos }
    end
  end

  # GET /room_photos/1
  # GET /room_photos/1.json
  def show
    @room_photo = RoomPhoto.find(params[:id])
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room_photo }
    end
  end

  # GET /room_photos/new
  # GET /room_photos/new.json
  def new
    @room_photo = RoomPhoto.new
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room_photo }
    end
  end

  # GET /room_photos/1/edit
  def edit
    @room_photo = RoomPhoto.find(params[:id])
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]
  end

  # POST /room_photos
  # POST /room_photos.json
  def create
    @room_photo = RoomPhoto.new(params[:room_photo])
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]
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
    @room_photo = RoomPhoto.find(params[:id])
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]

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
    @room_photo = RoomPhoto.find(params[:id])
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]
    @room_photo.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotel_room_photos_path(@hotel, @room) }
      format.json { head :no_content }
    end
  end
end

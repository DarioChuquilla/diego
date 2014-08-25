class Admin::RoomsController < Admin::BaseController
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /rooms
  # GET /rooms.json
  def index
    get_hotel
    #@rooms = Room.all
    @rooms = Room.find_all_by_hotel_id params[:hotel_id]
    respond_to do |format|
      format.html and return # index.html.erb
      format.json { render json: @rooms } and return
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    get_hotel
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    get_hotel
    @room = Room.new
    @room.hotel_id = params[:hotel_id]
    respond_to do |format|
      format.html and return # new.html.erb
      format.json { render json: @room } and return
    end
  end

  # GET /rooms/1/edit
  def edit
    get_hotel
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    get_hotel
    @room = Room.new(params[:room])
    @room.hotel_id=params[:hotel_id]
    respond_to do |format|
      if @room.save
        format.html { redirect_to admin_hotel_rooms_path(@hotel), notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to admin_hotel_room_path(@room), notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    get_hotel
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotel_rooms_url(@hotel) } and return
      format.json { head :no_content } and return
    end
  end

  private

  def authorizations
    begin
      @room = Room.find(params[:id])
      authorize! :manage, @room
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end

end

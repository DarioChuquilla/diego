class Admin::SpecialtiesController < Admin::BaseController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /specialties
  # GET /specialties.json
  def index
    get_hotel
    get_room
    @specialties = Specialty.find_all_by_hotel_id_and_room_id(params[:hotel_id], params[:room_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @specialties }
    end
  end

  # GET /specialties/1
  # GET /specialties/1.json
  def show
    get_hotel
    get_room
    @specialty = Specialty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @specialty }
    end
  end

  # GET /specialties/new
  # GET /specialties/new.json
  def new
    get_hotel
    get_room
    @specialty = Specialty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @specialty }
    end
  end

  # GET /specialties/1/edit
  def edit
    get_hotel
    get_room
    @specialty = Specialty.find(params[:id])
  end

  # POST /specialties
  # POST /specialties.json
  def create
    get_hotel
    get_room
    @specialty = Specialty.new(params[:specialty])
    @specialty.hotel_id = params[:hotel_id]
    @specialty.room_id = params[:room_id]
    respond_to do |format|
      if @specialty.save
        format.html { redirect_to admin_hotel_room_specialties_path(@hotel, @room), notice: 'Specialty was successfully created.' }
        format.json { render json: @specialty, status: :created, location: @specialty }
      else
        format.html { render action: "new" }
        format.json { render json: @specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /specialties/1
  # PUT /specialties/1.json
  def update
    get_hotel
    get_room
    @specialty = Specialty.find(params[:id])

    respond_to do |format|
      if @specialty.update_attributes(params[:specialty])
        format.html { redirect_to admin_hotel_room_specialty_path(@hotel, @room, @specialty), notice: 'Specialty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specialties/1
  # DELETE /specialties/1.json
  def destroy
    get_hotel
    get_room
    @specialty = Specialty.find(params[:id])
    @specialty.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotel_room_specialties_path(@hotel, @room) }
      format.json { head :no_content }
    end
  end

  def get_specialties_list
    criteria = params[:name]
    criteria = "%#{criteria}%"
    @specialties = Specialty.select(:name).where('specialties.name ILIKE ?', criteria).order(:name).uniq
  end

  private

  def authorizations
    begin
      @specialty = Specialty.find(params[:id])
      authorize! :manage, @specialty
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end
end

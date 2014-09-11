class Admin::SpecialtiesController < Admin::BaseController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /specialties
  # GET /specialties.json
  def index
    get_hotel
    @specialties = Specialty.find_by_hotel_id(params[:hotel_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @specialties }
    end
  end

  # GET /specialties/1
  # GET /specialties/1.json
  def show
    get_hotel
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
    @specialty = Specialty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @specialty }
    end
  end

  # GET /specialties/1/edit
  def edit
    get_hotel
    @specialty = Specialty.find(params[:id])
  end

  # POST /specialties
  # POST /specialties.json
  def create
    get_hotel
    @specialty = Specialty.new(params[:specialty])
    @specialty = params[:hotel_id]
    respond_to do |format|
      if @specialty.save
        format.html { redirect_to admin_hotel_specialties_path, notice: 'Specialty was successfully created.' }
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
    @specialty = Specialty.find(params[:id])

    respond_to do |format|
      if @specialty.update_attributes(params[:specialty])
        format.html { redirect_to admin_hotel_specialties_path(params[:hotel_id], @specialty), notice: 'Specialty was successfully updated.' }
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
    @specialty = Specialty.find(params[:id])
    @specialty.destroy

    respond_to do |format|
      format.html { redirect_to specialties_url }
      format.json { head :no_content }
    end
  end

  def get_specialties_list
    
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

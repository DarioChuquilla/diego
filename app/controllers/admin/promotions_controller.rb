class Admin::PromotionsController < Admin::BaseController
  load_and_authorize_resource
  before_filter :authorizations, :only => [:show, :edit, :update, :destroy]
  # GET /promotions
  # GET /promotions.json
  def index 
    get_hotel
    #@promotions = Promotion.all
    @promotions = Promotion.find_all_by_hotel_id params[:hotel_id]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @promotions }
    end
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show

    @promotion = Promotion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @promotion }
    end
  end

  # GET /promotions/new
  # GET /promotions/new.json
  def new
    get_hotel
    @promotion = Promotion.new
    @promotion.hotel_id = params[:hotel_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @promotion }
    end
  end

  # GET /promotions/1/edit
  def edit
    get_hotel
    @promotion = Promotion.find(params[:id])
  end

  # POST /promotions
  # POST /promotions.json
  def create
    get_hotel
    @promotion = Promotion.new(params[:promotion])
    @promotion.hotel_id=params[:hotel_id]
    #abort(params.inspect)
    respond_to do |format|
      if @promotion.save
        format.html { redirect_to admin_hotel_promotions_path(@hotel), notice: 'Promotion was successfully created.' }
        format.json { render json: @promotion, status: :created, location: @promotion }
      else
        format.html { render action: "new" }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /promotions/1
  # PUT /promotions/1.json
  def update
    @promotion = Promotion.find(params[:id])

    respond_to do |format|
      if @promotion.update_attributes(params[:promotion])
        format.html { redirect_to admin_hotel_promotion_path(@promotion), notice: 'Promotion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    get_hotel
    @promotion = Promotion.find(params[:id])
    @promotion.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotel_promotions_url(@hotel) }
      format.json { head :no_content }
    end
  end

  private

  def authorizations
    begin
      @promotion = Promotion.find(params[:id])
      authorize! :manage, @promotion
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end
end

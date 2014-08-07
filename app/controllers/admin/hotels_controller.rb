class Admin::HotelsController < ApplicationController
  # GET /admin/hotels
  # GET /admin/hotels.json
  def index
    @admin_hotels = Admin::Hotel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_hotels }
    end
  end

  # GET /admin/hotels/1
  # GET /admin/hotels/1.json
  def show
    @admin_hotel = Admin::Hotel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_hotel }
    end
  end

  # GET /admin/hotels/new
  # GET /admin/hotels/new.json
  def new
    @admin_hotel = Admin::Hotel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_hotel }
    end
  end

  # GET /admin/hotels/1/edit
  def edit
    @admin_hotel = Admin::Hotel.find(params[:id])
  end

  # POST /admin/hotels
  # POST /admin/hotels.json
  def create
    @admin_hotel = Admin::Hotel.new(params[:admin_hotel])

    respond_to do |format|
      if @admin_hotel.save
        format.html { redirect_to @admin_hotel, notice: 'Hotel was successfully created.' }
        format.json { render json: @admin_hotel, status: :created, location: @admin_hotel }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/hotels/1
  # PUT /admin/hotels/1.json
  def update
    @admin_hotel = Admin::Hotel.find(params[:id])

    respond_to do |format|
      if @admin_hotel.update_attributes(params[:admin_hotel])
        format.html { redirect_to @admin_hotel, notice: 'Hotel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/hotels/1
  # DELETE /admin/hotels/1.json
  def destroy
    @admin_hotel = Admin::Hotel.find(params[:id])
    @admin_hotel.destroy

    respond_to do |format|
      format.html { redirect_to admin_hotels_url }
      format.json { head :no_content }
    end
  end
end

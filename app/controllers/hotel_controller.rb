class HotelController < ApplicationController
  def nearest
    @type_name = params[:type_name].present? ? params[:type_name] : 'Motel'
    p "=========================="
    p @type_name
    @latitude = request.location.latitude == 0 ? -0.2166667 : request.location.latitude
    @longitude = request.location.longitude  == 0 ? -78.5 : request.location.longitude
    if params[:city].present?
      city = params[:city]
    else
      city = request.location.city.blank? ? "Quito" : request.location.city
    end
    @hotels = Array.new
    @hotel_dots = Hotel.active.where('hotels.type_name = ?', @type_name)
    _hotels = Hotel.active.where('hotels.type_name = ?', @type_name)
    _hotels.each do |hotel|
      @hotels << hotel if hotel.city == city
    end
  end

  def show
    @hotel = Hotel.find params[:id]
  end

  def room
    @hotel = Hotel.find params[:id]
    @room = Room.find params[:room_id]
  end

  def price
  end

  def cities
  end

  def promo
  end

  def reservations
    @hotel = Hotel.find params[:id]
    @room = Room.find params[:room_id]
  end

  def get_hotels_by_city
    point = Hotel.city_point params[:city], params[:type]
    respond_to do |format|
      format.js { render text: point.to_s }
      format.json { render json: point }
    end
  end

  def get_hotels_nearby
    # @radious = (params[:distance].to_f) / 1000 #Distance is requested in meters, setting it to KMs
    @radious = ((params[:distance].to_f * 1.02) / 1000.0) * Math.sin(Geocoder::Calculations.to_radians(45)) #Distance for circular maps canvas
    box = Geocoder::Calculations.bounding_box([params[:lat], params[:lng]], @radious, :units => :km)
    # @hotels = Hotel.active.near [params[:lat], params[:lng]], @radious, :units => :km #for circular map
    @type_name = params[:type_name].present? ? params[:type_name] : 'Motel'

    @hotels = Hotel.active.where('hotels.type_name = ?', @type_name).within_bounding_box(box)
    respond_to do |format|
      format.js # show.html.erb
      format.json { render json: @hotels }
    end
  end
end

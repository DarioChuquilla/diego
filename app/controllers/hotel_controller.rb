class HotelController < ApplicationController
  def show
  end

  def nearest
    @hotels = Hotel.all
  end

  def price
  end

  def cities
  end

  def promo
  end
end

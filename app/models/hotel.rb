class Hotel < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :name, :telephone, :email, :type_name
  validates_presence_of :name, :description, :type_name

  belongs_to :user
  has_many :promotions
  has_many :rooms
  has_many :hotel_photos
  has_many :comments

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode
  after_save :address_by_geo

  before_destroy :remove_related

  scope :active, where('active = ?', true)

  def city
    query = self.latitude.to_s + "," + self.longitude.to_s
    result = Geocoder.search(query).first 
    if (result)
      result.city
    else
      nil
    end
  end

  def self.cities
    cities = Array.new
    hotels = Hotel.active
    hotels.each do |hotel|
      query = hotel.latitude.to_s + "," + hotel.longitude.to_s
      result = Geocoder.search(query).first 
      if (result)
        cities << result.city
      end
    end
    return cities.uniq
  end

  def self.city_point(city, type_name = nil)
    hotels_list = Array.new
    hotels = Hotel.active
    hotels = hotels.where('hotels.type_name = ?', type_name) if !type_name.nil?
    hotels.each do |hotel|
      hotels_list << hotel if hotel.city == city
    end
    Geocoder::Calculations.geographic_center(hotels_list)
  private

  def remove_related
    self.promotions.destroy_all
    self.rooms.destroy_all
    self.hotel_photos.destroy_all
  end

  def address_by_geo
    if self.address.nil? || self.address.blank?
      self.address = self.reverse_geocode
      self.save
    end
  end

end

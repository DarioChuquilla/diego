class Hotel < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :name, :telephone, :email
  validates_presence_of :name, :description
  belongs_to :user
  has_many :promotions
  has_many :rooms
  has_many :hotel_photos

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode, :if => :address_changed? and :location.nil?
end

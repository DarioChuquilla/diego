class Hotel < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :name, :telephone, :email
  validates_presence_of :name, :description
  belongs_to :user
  has_many :promotions
  has_many :hotel_photos
end

class Hotel < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :name
  validates_presence_of :name, :description
  belongs_to :user
  has_many :promotions
end

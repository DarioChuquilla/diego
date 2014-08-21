class Room < ActiveRecord::Base
  attr_accessible :name, :description, :amount
  belongs_to :hotel
  validates_presence_of :name, :description, :amount, :hotel_id
end

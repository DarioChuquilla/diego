class Promotion < ActiveRecord::Base
  attr_accessible :code, :description, :end_date, :initial_date, :name , :percentage_discount, :hotel_id
  belongs_to :hotel
  validates :code, :description, :end_date, :initial_date, :name , :percentage_discount,:hotel_id, :presence => true
end

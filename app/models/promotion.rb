class Promotion < ActiveRecord::Base
  attr_accessible :code, :description, :end_date, :initial_date, :name , :percentage_discount, :id_hotel
  belongs_to :hotel
  validates :code, :description, :end_date, :initial_date, :name , :percentage_discount,:id_hotel, :presence => true
end

class Specialty < ActiveRecord::Base
  belongs_to :hotel
  attr_accessible :hotel_id, :name, :description
  validates_presence_of :name

end

class Promotion < ActiveRecord::Base
  attr_accessible :code, :description, :end_date, :initial_date, :name, :percentage_discount
  belongs_to :hotel
end

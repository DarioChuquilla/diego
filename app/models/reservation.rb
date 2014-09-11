class Reservation < ActiveRecord::Base
   attr_accessible :date_in, :date_out, :total_price
   validates_presence_of :date_in, :date_out
end

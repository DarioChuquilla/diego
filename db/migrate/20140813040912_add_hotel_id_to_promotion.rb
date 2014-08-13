class AddHotelIdToPromotion < ActiveRecord::Migration
  def change
    add_column :promotions, :hotel_id, :integer
    remove_column :promotions, :id_hotel
  end
end

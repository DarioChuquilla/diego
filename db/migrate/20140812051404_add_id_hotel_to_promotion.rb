class AddIdHotelToPromotion < ActiveRecord::Migration
  def change
    add_column :promotions, :id_hotel, :integer
  end
end

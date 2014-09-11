class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :date_in
      t.datetime :date_out
      t.integer :room_id
      t.integer :hotel_id
      t.integer :user_id
      t.decimal :total_price

      t.timestamps
    end
  end
end

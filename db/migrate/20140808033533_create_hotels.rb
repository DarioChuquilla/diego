class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
    add_index :hotels, :latitude
    add_index :hotels, :longitude
  end
end

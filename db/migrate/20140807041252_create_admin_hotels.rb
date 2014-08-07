class CreateAdminHotels < ActiveRecord::Migration
  def change
    create_table :admin_hotels do |t|
      t.string :name
      t.text :address
      t.text :description
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end

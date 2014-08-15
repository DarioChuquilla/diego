class AddDetailsToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :telephone, :string
    add_column :hotels, :email, :string
  end
end

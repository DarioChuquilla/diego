class AddColumsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :frist_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile, :string
  end
end

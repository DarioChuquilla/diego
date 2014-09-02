class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.datetime :date
      t.integer :rank
      t.text :description
      t.integer :user_id
      t.integer :hotel_id
      t.boolean :active, default: false

      t.timestamps
    end
  end
end

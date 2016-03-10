class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string  :restaurant
      t.string  :name
      t.integer :price
      t.time    :start
      t.time    :end
      
      t.timestamps null: false
    end
  end
end

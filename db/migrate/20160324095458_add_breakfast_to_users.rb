class AddBreakfastToUsers < ActiveRecord::Migration
  def change
    add_column :users, :breakfast, :text, :default => "You have no breakfast plan in place!"
    add_column :users, :lunch, :text, :default => "You have no lunch plan in place!"
    add_column :users, :dinner, :text, :default => "You have no dinner plan in place!"
  end
end

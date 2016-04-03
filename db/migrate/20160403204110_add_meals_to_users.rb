class AddMealsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meals, :integer, :default => 0
    add_column :users, :good_days, :integer, :default => 0
    add_column :users, :bad_days, :integer, :default => 0
  end
end

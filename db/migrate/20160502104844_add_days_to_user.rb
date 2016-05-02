class AddDaysToUser < ActiveRecord::Migration
  def change
    add_column :users, :days, :text, :default => ""
    add_column :users, :money_spent, :text, :default => ""
    add_column :users, :daily_spent, :integer, :default => 0
  end
end

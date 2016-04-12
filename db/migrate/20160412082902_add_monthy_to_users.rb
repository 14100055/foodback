class AddMonthyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :original_budget, :integer, :default => 0
    add_column :users, :month_budget, :integer, :default => 0
    add_column :users, :start_days, :integer, :default => -1
    add_column :users, :middle_days, :integer, :default => 0
    add_column :users, :end_days, :integer, :default => 0
    add_column :users, :remaining_days, :integer, :default => 0
  end
end

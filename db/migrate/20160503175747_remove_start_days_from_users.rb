class RemoveStartDaysFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :start_days, :integer
    remove_column :users, :middle_days, :integer
    remove_column :users, :end_days, :integer
    change_column :users, :remaining_days, :integer, :default => -1
  end
end

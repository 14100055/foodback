class DaysBeforeDeadline < ActiveRecord::Migration
  def change
    add_column :users, :days_before_deadline, :integer, :default => 0
  end
end

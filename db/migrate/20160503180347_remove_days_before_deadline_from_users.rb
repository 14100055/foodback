class RemoveDaysBeforeDeadlineFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :days_before_deadline, :integer
  end
end

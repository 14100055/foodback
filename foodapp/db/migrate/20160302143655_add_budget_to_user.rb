class AddBudgetToUser < ActiveRecord::Migration
  def change
    add_column :users, :budget, :integer, :default => 0
  end
end

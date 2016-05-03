class Split < ActiveRecord::Migration
  def change
    add_column :users, :split_budget, :integer, :default => 0
    add_column :users, :deadline, :integer, :default => 0
  end
end

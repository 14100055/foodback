class AddPlanToUser < ActiveRecord::Migration
  def change
    add_column :users, :plan, :text, :default => "You have no meal plan in place!"
  end
end

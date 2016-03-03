class AddPlanToUser < ActiveRecord::Migration
  def change
    add_column :users, :plan, :text
  end
end

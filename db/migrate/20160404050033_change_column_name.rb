class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :plan, :favourites
    change_column_default :users, :favourites, ""
  end
end

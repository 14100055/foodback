class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :foods, :start, :start_at
    rename_column :foods, :end, :end_at
  end
end

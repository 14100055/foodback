class Users < ActiveRecord::Migration
  def change
    add_column :users, :exotic, :text, :default => "Its not the last day yet. :( "
  end
end

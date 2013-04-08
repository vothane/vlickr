class AddPlayerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :player, :text
  end
end

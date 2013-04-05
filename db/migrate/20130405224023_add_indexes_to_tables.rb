class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :albums, :user_id
    add_index :videos,   [:album_id, :created_at]
    add_index :comments, [:video_id, :created_at]
  end
end
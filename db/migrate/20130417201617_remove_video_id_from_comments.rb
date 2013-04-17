class RemoveVideoIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :video_id, :integer
    remove_index  :comments, [:video_id, :created_at]
  end
end

class AddAssetToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :asset, :text
  end
end

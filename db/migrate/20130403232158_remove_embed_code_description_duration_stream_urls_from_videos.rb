class RemoveEmbedCodeDescriptionDurationStreamUrlsFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :embed_code, :string
    remove_column :videos, :description, :string
    remove_column :videos, :duration, :integer
    remove_column :videos, :stream_urls, :text
  end
end

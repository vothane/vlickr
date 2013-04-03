class AddEmbedCodeDescriptionDurationStreamUrlsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :embed_code, :string
    add_column :videos, :description, :string
    add_column :videos, :duration, :integer
    add_column :videos, :stream_urls, :text
  end
end

class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :embed_code
      t.string :title
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end

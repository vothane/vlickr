class AddFileAttributesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :file, :string

    add_column :videos, :size, :integer

  end
end

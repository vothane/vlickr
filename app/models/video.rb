class Video < ActiveRecord::Base
  attr_accessor :embed_code, :title, :description, :image_url

  belongs_to :album
  has_many   :comments
  
  after_save    :upload_video
  after_destroy :destroy_video
  
  validates :embed_code,  :presence => true
  validates :title,       :presence => true
  validates :description, :presence => true, :length => { :minimum => 10 }
  validates :image_url,   :presence => true
  
  private
  
  def upload_video
    Asset::upload_video(self)
  end
  
  def destroy_video
    video = Asset.find(:embed_code)
    video.destroy
  end
end
class Video < ActiveRecord::Base
  attr_accessor :embed_code, :title, :description, :image_url

  belongs_to :album
  has_many   :comments
  
  before_save   :upload_video
  after_destroy :destroy_video
  
  validates :embed_code,  :presence => true
  validates :title,       :presence => true
  validates :description, :presence => true, :length => { :minimum => 10 }
  validates :image_url,   :presence => true
  
  private
  
  def upload_video
    video            = Asset.new
    video.name       = ''
    video.file_name  = ''
    video.asset_type = ''
    video.file_size  = ''
    video.chunk_size = ''
    # One of [live, paused]
    video.status     = "live"
    video.save
  end
  
  def destroy_video
    video = Asset.find(:embed_code)
    video.destroy
  end
end
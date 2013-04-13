class Video < ActiveRecord::Base 
  serialize :asset, Asset
 
  belongs_to :album
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  scope :recent, -> { order('created_at desc').limit(6) }
  
  before_destroy Proc.new { |video| video.asset.destroy }

  validates :asset, :presence => true  

  delegate :name, :embed_code, :description, :duration, :status, :preview_image_url, :to => :asset
end

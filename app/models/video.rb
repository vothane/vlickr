class Video < ActiveRecord::Base 
  serialize :asset, Asset

  belongs_to :album

  scope :recent, -> { order('created_at desc').limit(4) }
  
  before_destroy Proc.new { |video| video.asset.destroy }

  validates :asset, :presence => true  

  delegate :name, :embed_code, :description, :duration, :status, :to => :asset
end

class Video < ActiveRecord::Base 
  serialize :asset, Asset

  belongs_to :album
  
  before_destroy Proc.new { |video| video.asset.destroy }

  validates :asset, :presence => true  

  delegate :name, :embed_code, :desription, :duration, :status, :to => :asset
end

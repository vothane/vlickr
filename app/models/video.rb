class Video < ActiveRecord::Base 
  attr_accessor :asset

  delegate :name, :embed_code, :desription, :duration, :stream_urls, :to => :asset
end

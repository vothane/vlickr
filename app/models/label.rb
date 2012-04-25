$:.unshift(File.join(File.dirname(__FILE__), ".", "acts_as_voodoo"))
require 'acts_as_voodoo'

class Label < ActiveResource::Base

  acts_as_voodoo :api_key => APP_CONFIG['ooyala_api']['api_key'], :api_secret => APP_CONFIG['ooyala_api']['api_secret']

  self.site = "https://api.ooyala.com/v2"
  
  def self.create_label(title)
    label = self.new
    label.name = title
    label.save
  end
end
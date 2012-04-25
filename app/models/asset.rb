$:.unshift(File.join(File.dirname(__FILE__), ".", "acts_as_voodoo"))
require 'acts_as_voodoo'
require 'ooyala'

class Asset < ActiveResource::Base

  acts_as_voodoo :api_key => APP_CONFIG['ooyala_api']['api_key'], :api_secret => APP_CONFIG['ooyala_api']['api_secret']

  self.site = "https://api.ooyala.com/v2"
  
  def self.upload_video(video_record)
    video            = self.new
    video.name       = video_record.title
    video.file_name  = video_record.file
    video.asset_type = 'asset'
    video.file_size  = video_record.size
    video.post_processing_status = 'live'
    video.save
    
    path       = "/#{video_record.embed_code}/uploading_urls"
    upload_url = Asset.find(:all, :from => path).first
    params     = { 'api_key' => APP_CONFIG['ooyala_api']['api_key'], 'expires' => OOYALA::expires }
    signature  = OOYALA::generate_signature( APP_CONFIG['ooyala_api']['api_secret'], "GET", path, params, nil )
    upload_url = "#{upload_url}?api_key=#{:api_key}&expires=#{params['expires']}&signature=#{signature}"
    
    EventMachine.run {
      http = EventMachine::HttpRequest.new(upload_url).post :file => video_record.file
      http.callback { 
        video_asset.put("#{video_record.embed_code}/upload_status", { :status => "uploaded" })
      }
      http.errback { 
        # notify user that upload failed
      }
    }
  end
end
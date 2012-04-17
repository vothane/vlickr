$:.unshift(File.join(File.dirname(__FILE__), ".", "acts_as_voodoo"))
require 'acts_as_voodoo'

class Asset < ActiveResource::Base
  my_api_key    = 'JkN2w61tDmKgPl4y395Rp1vAdlcq.IqBgb'
  my_api_secret = 'nU2WjeYoEY0MJKtK1DRpp1c6hNRoHgwpNG76dJkX'

  acts_as_voodoo :api_key => my_api_key, :api_secret => my_api_secret

  self.site = "https://api.ooyala.com/v2"
  def self.upload_video(video_record)
    video            = self.new
    video.name       = video_record.title
    video.file_name  = video_record.file
    video.asset_type = 'asset'
    video.file_size  = video_record.size
    video.post_processing_status = 'live'
    video.save

    upload_factory = UploadFactory.instance

    upload_factory.upload(video, video_record)
  end
end

class UploadFactory
  include Singleton
  def upload(video_asset, video_record)
    upload_url = Asset.find(:all, :from => "/#{video_record.asset.embed_code}/uploading_urls").first

    EventMachine.run {
      http = EventMachine::HttpRequest.new(upload_url).post :file => video_record.file
      http.callback { 
        video_asset.put("#{video_record.embed_code}/upload_status", { :status => "uploaded" })
      }
    }
  end
end
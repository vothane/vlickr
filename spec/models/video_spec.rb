require 'spec_helper'

describe Video do
  context "when creating a new video" do
    let(:asset_video) do
      results = Asset.find(:one) do |vid|
        vid.description == "Thor"
        vid.duration > 600
      end
      results.first
    end  

    let(:video) do
      video = Video.new
      video.video = asset_video
      video
    end  

    it "should be valid" do
      video.should be_valid
    end  
  end  
end

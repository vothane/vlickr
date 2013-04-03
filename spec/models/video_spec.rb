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
      video.asset = asset_video
      video
    end  

    it "should be valid" do
      video.name.should == "Thor"
    end  

    it "should be an instance of AsyncConnection" do
      video.stream_urls.should be_instance_of( Array )
    end
  end  
end

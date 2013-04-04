require 'spec_helper'

describe Video do

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

  context "when creating a new video" do

    it "should be valid" do
      video.should be_valid
    end  

    it "should be valid name" do
      video.name.should == "Thor"
    end  

  end 

  context 'when destroying video instance' do

    it 'should call asset destroy method in before_destroy callback' do
      asset_video.should_receive( :destroy )

      video.destroy
    end

  end  
end

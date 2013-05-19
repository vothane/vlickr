require "spec_helper"

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

  subject { video }

  it { should respond_to(:name) }
  it { should respond_to(:embed_code) }
  it { should respond_to(:description) }
  it { should respond_to(:embed_code) }
  it { should respond_to(:duration) }
  it { should respond_to(:status) }

  it { should be_valid }

  context "when creating a new video" do

    it "should be valid name" do
      video.name.should == "Hear Me Roar!"
    end  

  end 

  context "when destroying video instance" do

    it "should call asset destroy method in before_destroy callback" do
      asset_video.should_receive( :destroy )

      video.destroy
    end

  end  

  context "when using scope querys" do

    it "should find recent videos" do
      Video.recent.count.should == 4
    end

  end  

end

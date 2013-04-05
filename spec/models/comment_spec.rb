require 'spec_helper'

describe Comment do

  let(:asset_video) { Asset.find(:one) { |vid| vid.name == "Iron Sky" } }

  let(:video) do
    video = Video.new
    video.asset = asset_video
    video
  end  

  before do
    @comment = comment.new(content: "Lorem ipsum and sum", video_id: 2)
  end
  
  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:video_id) }

  describe "when video_id is not present" do
    before { @comment.video_id = nil }
    it { should_not be_valid }
  end
  
  describe "when video_id is not present" do
    before { @comment.video_id = nil }
    it { should_not be_valid }
  end
    
  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @comment.content = "a" * 141 }
    it { should_not be_valid }
  end

end

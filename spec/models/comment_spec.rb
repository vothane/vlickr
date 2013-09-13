require 'spec_helper'
require 'active_resource'

describe Comment do

  let(:video) do
    video = Video.new
    video.asset = Asset.new
    video
  end  

  before do
    @comment = Comment.new(content: "Lorem ipsum and sum",)
  end
  
  subject { @comment }

  it { should respond_to(:content) }

  describe "when validated" do
    it { should be_valid }
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

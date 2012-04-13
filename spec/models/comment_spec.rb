require 'spec_helper'

describe Comment do

  before(:each) do
    @video = Factory(:video)
    @attr = { :content => "lorem ipsum yada yada foobar" }
  end

  it "should create a new instance with valid attributes" do
    @video.comments.create!(@attr)
  end

  describe "video associations" do

    before(:each) do
      @comment = @video.comments.create(@attr)
    end

    it "should have a video attribute" do
      @comment.should respond_to(:video)
    end

    it "should have the right associated video" do
      @comment.video_id.should == @video.id
      @comment.video.should == @video
    end
  end

  describe "validations" do

    it "should have a video id" do
      comment.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @video.comments.build(:content => "    ").should_not be_valid
    end

    it "should reject long content" do
      @video.comments.build(:content => "a" * 141).should_not be_valid
    end
  end
end

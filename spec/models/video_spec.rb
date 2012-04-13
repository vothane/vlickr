require 'spec_helper'

describe Video do

  before(:each) do
    @album = Factory(:album)
    @attr = { :embed_code => "g0YzBnMjoGiHUtGoWW4pFzzhTZpKLZUi", :title => "lorem", :description => "lorem ipsum yada yada", :image_url => "www.exaple.com/pic.jpeg" }
  end
  
  it "should create a new instance with valid attributes" do
    @album.videos.create!(@attr)
  end
  
  describe "album associations" do
    
    before(:each) do
      @video = @album.videos.create(@attr)
    end
    
    it "should have a album attribute" do
      @video.should respond_to(:album)
    end
    
    it "should have the right associated album" do
      @video.album_id.should == @album.id
      @video.album.should == @album
    end
  end
  
  describe "validations" do

    it "should have a album id" do
      @video.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @album.videos.build(:description => "    ").should_not be_valid
    end
    
    it "should reject long content" do
      @album.videos.build(:description => "a" * 141).should_not be_valid
    end
  end
end

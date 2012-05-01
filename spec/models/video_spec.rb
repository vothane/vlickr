require 'spec_helper'

describe Video do

  let(:album) { FactoryGirl.create(:album) }
  before { @video = album.videos.build( :embed_code => "g0YzBnMjoGiHUtGoWW4pFzzhTZpKLZUi", :title => "lorem", :description => "lorem ipsum yada yada", :image_url => "www.exaple.com/pic.jpeg" ) }

  subject { @video }

  it { should respond_to(:title) }
  it { should respond_to(:album_id) }
  it { should respond_to(:album) }
  its(:album) { should == album }

  it { should be_valid }
  
  before(:each) do
    @album = Factory(:album)
    @attr = { :embed_code => "g0YzBnMjoGiHUtGoWW4pFzzhTZpKLZUi", :title => "lorem", :description => "lorem ipsum yada yada", :image_url => "www.exaple.com/pic.jpeg" }
    @asset = mock_model('Asset')
    @asset.stub!(:upload_video).and_return(true)
  end

  it "should create a new instance with valid attributes" do
    Asset.stub!(:upload_video).and_return(true)
    @album.videos.create!(@attr)
  end

  describe "album associations" do

    before(:each) do
      Asset.stub!(:upload_video).and_return(true)
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
      @album.videos.new(@attr).should be_valid
    end

    it "should require nonblank content" do
      @album.videos.build(:description => "    ").should_not be_valid
    end

    it "should reject long content" do
      @album.videos.build(:description => "a" * 141).should_not be_valid
    end
  end
  
  describe "accessible attributes" do
    it "should not allow access to album_id" do
      expect do
        @album.videos.new(:album_id => album.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "acts_as_voodoo integration" do

    it "should send a create call when created" do
      Asset.stub!(:upload_video).and_return(true)
      @album.videos.create(@attr)
    end
  end
end

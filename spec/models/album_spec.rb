require 'spec_helper'

describe Album do

  before(:each) do
    @user = Factory(:user)
    @attr = { :title => "lorem ipsum", :description => "lorem ipsum yada yada" }
  end
  
  it "should create a new instance with valid attributes" do
    @user.albums.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @album = @user.albums.create(@attr)
    end
    
    it "should have a user attribute" do
      @album.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @album.user_id.should == @user.id
      @album.user.should == @user
    end
  end
  
  describe "validations" do

    it "should have a user id" do
      album.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.albums.build(:description => "    ").should_not be_valid
    end
    
    it "should reject long content" do
      @user.albums.build(:description => "a" * 141).should_not be_valid
    end
  end
end

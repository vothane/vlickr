require 'spec_helper'

describe Album do

  let(:user) { FactoryGirl.create(:user) }
  before do 
    @label = mock_model('Label')
    Label.stub!(:create_label).and_return(true)
    @album = user.albums.build(:title => "lorem ipsum and some", :description => "lorem yada yada") 
  end
  subject { @album }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :title => "lorem ipsum", :description => "lorem ipsum yada yada" }
    @label = mock_model('Label')
    @label.stub!(:create_label).and_return(true)
  end
  
  it "should create a new instance with valid attributes" do
    Label.should_receive(:create_label).and_return(true)
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
    
    before(:each) do
      @album = @user.albums.create(@attr)
    end

    it "should have a user id" do
      Album.create(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.albums.build(:description => "    ").should_not be_valid
    end
    
    it "should reject long content" do
      @user.albums.build(:description => "a" * 141).should_not be_valid
    end
  end
end

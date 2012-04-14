require 'spec_helper'

describe Relationship do
  describe "basic relationships model" do
    before(:each) do
      @follower = Factory(:user)
      @followed = Factory(:user, :email => Factory.next(:email))

      @attr = { :followed_id => @followed.id }
    end

    it "should create a new instance with valid attributes" do
      @follower.relationships.create!(@attr)
    end

    describe "follow methods" do

      before(:each) do
        @relationship = @follower.relationships.create!(@attr)
      end

      it "should have a follower attribute" do
        @relationship.should respond_to(:follower)
      end

      it "should have the right follower" do
        @relationship.follower.should == @follower
      end

      it "should have a followed attribute" do
        @relationship.should respond_to(:followed)
      end

      it "should have the right followed user" do
        @relationship.followed.should == @followed
      end
    end

    describe "validations" do

      it "should require a follower id" do
        Relationship.new(@attr).should_not be_valid
      end

      it "should require a followed id" do
        @follower.relationships.build.should_not be_valid
      end
    end
  end
  
  describe "relationships behavior among user instances" do
    
    let(:follower) { FactoryGirl.create(:user) }
    let(:followed) { FactoryGirl.create(:user) }
    let(:relationship) do
      follower.relationships.build(followed_id => followed.id)
    end
  
    subject { relationship }
  
    it { should be_valid }

    describe "accessible attributes" do
      it "should not allow access to follower_id" do
        expect do
          Relationship.new(follower_id => follower.id)
        end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end    
    end
  
    describe "follower methods" do
      before { relationship.save }
  
      it { should respond_to(:follower) }
      it { should respond_to(:followed) }
      its(:follower) { should == follower }
      its(:followed) { should == followed }
    end
  
    describe "when followed id is not present" do
      before { relationship.followed_id = nil }
      it { should_not be_valid }
    end
  
    describe "when follower id is not present" do
      before { relationship.follower_id = nil }
      it { should_not be_valid }
    end
  end
end
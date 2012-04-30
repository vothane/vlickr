require 'spec_helper'

describe User do
  describe "a basic user model" do

    before { @user = User.create!( :name => "Cosmo Politan", :email => "fasf@example.com" ) }
    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:comments) }
    it { should respond_to(:albums) }
    it { should respond_to(:relationships) }
    it { should respond_to(:followers) }
    it { should respond_to(:follow) }
    it { should respond_to(:unfollow) }

    it { should be_valid }

  end

  describe "a user object interacting" do

    before(:each) do
      @attr = {
        :name => "Example User",
        :email => "user@example.com"
      }
    end

    it "should create a new instance given a valid attribute" do
      User.create!(@attr)
    end

    it "should require a name" do
      no_name_user = User.new(@attr.merge(:name => ""))
      no_name_user.should_not be_valid
    end

    it "should require an email address" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end

    it "should reject names that are too long" do
      long_name = "a" * 51
      long_name_user = User.new(@attr.merge(:name => long_name))
      long_name_user.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end

  describe "users followed dynamics" do

    let(:user)       { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    let(:third_user) { FactoryGirl.create(:user) }
    let(:follower)   { FactoryGirl.create(:user) }
    let(:followed)   { FactoryGirl.create(:user) }
    let(:relationship) do
      follower.relationships.build(followed_id => followed.id)
    end

    before { user.follow!(other_user) }

    let(:own_post)        { user.comments.create!(:content => "lorem ipsum whatever") }
    let(:followed_post)   { other_user.comments.create!(:content => "lorem ipsum @#$$") }
    let(:unfollowed_post) { third_user.comments.create!(:content => "fkdtjdtuh rr") }

    subject { comment.from_users_followed_by(user) }

    it { should include(own_post) }
    it { should include(followed_post) }
    it { should_not include(unfollowed_post) }
  end

  describe "following" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      user.save
      user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(user) }
    end

    describe "and unfollowing" do
      before { user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end
end
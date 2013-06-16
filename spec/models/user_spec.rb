require "spec_helper"

describe User do

  let(:user) do
    User.new(name: "Mac User", email: "John.Ghay#{random_string}@asylum.com", user_name: "The_Fraud",
             password: "SpreadingTheDiseaseOfFailure", password_confirmation: "SpreadingTheDiseaseOfFailure")
  end

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:user_name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:player_code) }
  it { should respond_to(:admin) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }

  it { should be_valid }
  it { should_not be_admin }

  context "callbacks" do
    describe "#save_user!" do
      it "downcases email" do
        user.email.should_receive(:downcase!).and_return("john.ghay@nuthouse.com")
        user.email = "John.Ghay@NutHouse.com"
        user.save
        user.email.should == "John.Ghay@nuthouse.com"
      end
    end
  end

  context "when email" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  context "video associations" do

    let(:abuser) do
      User.new(name: "Example User", email: "user@example.com", user_name: "user1",
               password: "SpreadingTheDiseaseOfFailure", password_confirmation: "SpreadingTheDiseaseOfFailure")
    end

    before { abuser.save }

    let(:asset_video_1) do
      results = Asset.find(:one) do |vid|
        vid.description == "Thor"
        vid.duration > 600
      end
      results.first
    end  

    let(:asset_video_2) do
      results = Asset.find(:one) do |vid|
        vid.description == "Avengers"
        vid.duration > 600
      end
      results.first
    end  

    let!(:older_video) do
      FactoryGirl.create(:video, asset: asset_video_1, created_at: 1.day.ago)
    end

    let!(:newer_video) do
      FactoryGirl.create(:video, asset: asset_video_2, created_at: 1.hour.ago)
    end

    it "should have the right videos in the right order" do
      expect(abuser.videos.to_a).to eql([newer_video, older_video])
    end

    it "should destroy associated videos" do
      videos = abuser.videos.dup.to_a
      abuser.destroy
      expect(videos).not_to be_empty

      videos.each do |video|
        expect(video.where(id: video.id)).to be_empty
      end

      videos.each do |video|
        expect do
          video.find(video)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context "when returning value of authenticate method" do

    before { user.save }

    let(:found_user) { User.find_by(email: user.email) }

    describe "with valid password" do
      it { should eql(found_user.authenticate(user.password)) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eql(user_for_invalid_password) }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  context "when remembering token" do

    before { user.save }

    its(:remember_token) { should_not be_blank }
  end

  context "when setting admin attribute to 'true'" do
    before do
      user.save!
      user.toggle!(:admin)
    end

    it { should be_admin }
  end

  context "when following" do
    let(:user)       { FactoryGirl.create(:user) } 
    let(:other_user) { FactoryGirl.create(:user) }    

    before do
      user.save
      user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(abuser) }
    end
    
    describe "and unfollowing" do
      before { user.unfollow!(other_user) }
      
      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end

  context "user activity feed" do
    let(:unfollowed_post) do
      FactoryGirl.create(:comment, user: FactoryGirl.create(:user))
    end
    let(:followed_user) { FactoryGirl.create(:user) }

    before do
      abuser.follow!(followed_user)
      3.times { followed_user.comments.create!(content: "Lorem ipsum") }
    end

    its(:feed) { should include(newer_comment) }
    its(:feed) { should include(older_comment) }
    its(:feed) { should_not include(unfollowed_post) }
    its(:feed) do
      followed_user.comments.each do |comment|
        should include(comment)
      end
    end
  end
end
require 'spec_helper'

describe "User UI" do
  
  subject { page }
    
    it { should have_title('users') }
    it { should have_content('users') }
    

  describe "profile page" do
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "videos" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

  describe "edit" do

    describe "page" do
      it { should have_content("profile") }
      it { should have_title("Edit user") }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password, 
                  password_confirmation: user.password } }
      end
      before { patch user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end
  end
end
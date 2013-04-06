require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Vlickr') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

    end
  end

  describe "About page" do
    before { visit about_path }
    
    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end


end
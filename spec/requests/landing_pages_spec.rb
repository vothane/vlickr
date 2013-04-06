require 'spec_helper'

describe "LandingPages" do
  describe "Static pages" do
    describe "Homepage" do

      it "should have the content 'Vlickr'" do
        visit '/staticpages/home'
        page.should have_content('Vlickr')
      end
      
    end
  end
end

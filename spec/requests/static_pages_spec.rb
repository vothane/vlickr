require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit '/static_pages/home' }

    it { should have_selector('h1', text: 'VLICKR') }
    it { should have_selector('title', text: '') }
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit '/static_pages/help' }

    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: 'Help') }
  end

  describe "About page" do
    before { visit '/static_pages/about' }

    it { should have_selector('h1', text: 'About') }
    it { should have_selector('title', text: 'About Us') }
  end

  describe "Contact page" do
    before { visit '/static_pages/contact' }

    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: 'Contact') }
  end

  it "should have the right links on the layout" do
    visit '/static_pages/home'
    click_link "About"
    page.should have_selector 'a', text: 'About'
    click_link "Help"
    page.should have_selector 'a', text: 'Help'
    click_link "Contact"
    page.should have_selector 'a', text: 'Contact'
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: 'Sign up'
    click_link "Vlickr"
    page.should have_selector 'h1', text: 'Vlickr'
  end
end

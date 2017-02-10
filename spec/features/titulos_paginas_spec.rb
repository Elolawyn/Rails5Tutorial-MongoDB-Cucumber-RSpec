require "rails_helper"

RSpec.feature "Titulos paginas", :type => :feature do

  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  scenario "root" do
    visit "/"
    expect(page).to have_title @base_title
  end

  scenario "help" do
    visit "/help"
    expect(page).to have_title "Help | #{@base_title}"
  end

  scenario "about" do
    visit "/about"
    expect(page).to have_title "About | #{@base_title}"
  end

  scenario "contact" do
    visit "/contact"
    expect(page).to have_title "Contact | #{@base_title}"
  end
end
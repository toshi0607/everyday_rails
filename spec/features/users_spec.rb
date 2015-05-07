require 'spec_helper'

feature 'User management' do
  scenario "adds a new user" do
    admin = create(:admin)

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin_password
    click_button 'Log In'

  end
end
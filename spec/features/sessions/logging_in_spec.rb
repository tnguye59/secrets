require 'rails_helper'
RSpec.describe 'logging in' do
  before do
    @user = create_user
    log_in @user

  end
  it 'prompts for email and password' do
    visit '/sessions/new'
    expect(page).to have_field('email')
    expect(page).to have_field('password')
  end
  it 'logs in user if email/password combination is valid' do
    log_in @user
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_text(@user.name)
  end
  it 'does not sign in user if email/password combination is invalid' do
    log_in @user, 'wrong password'
    expect(page).to have_text('Invalid')
  end
  it 'displays "Log Out" button when user is logged on' do
    expect(page).to have_button('Log Out')
  end
  it 'logs out user and redirects to login page' do
    click_button 'Log Out'
    expect(current_path).to eq('/sessions/new')
  end
end
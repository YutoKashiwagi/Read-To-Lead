require 'rails_helper'

RSpec.feature "TermsOfServices", type: :feature do
  before do
    visit new_user_registration_path
    fill_in 'Name', with: 'foobar'
    fill_in 'Email', with: 'foobar@foobar.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
  end
  
  it '利用規約に同意しなければサインアップできない事' do
    click_button 'Sign up'
    expect(page).to have_content('Accepted must be accepted')
  end
  
  it '利用規約に同意していればサインアップ出来る事' do
    check 'user_accepted'
    expect(page).to have_checked_field('user_accepted')
    click_button 'Sign up'
    expect(page).to have_content('読んだ本をシェアしよう！')
  end
end

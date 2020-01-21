require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  given!(:user) { FactoryBot.create(:user) }
  given!(:post) { FactoryBot.create(:post) }
  
  background do
    visit posts_path
  end
  
  scenario '検索していない場合' do
    expect(page).to have_content 'みんなの投稿'
  end
  
  scenario '実在する投稿を検索する場合' do
    fill_in '投稿を検索', with: 'title'
    click_on '検索'
    expect(page).to have_content '検索結果'
    expect(page).to have_selector("img[src$='suzu.jpg']")
  end
  
  scenario '実在しない投稿を検索する場合' do
    fill_in '投稿を検索', with: 'hoge'
    click_on '検索'
    expect(page).not_to have_selector("img[src$='suzu.jpg']")
  end
end

require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "乾杯する", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @drink = FactoryBot.create(:drink)
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは乾杯できる' do
      # ログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      # expect(page).to have_content('乾杯する')
      # 投稿ページに移動する
      visit new_drink_path
      # フォームに情報を入力する
      attach_file "drink[image]", "#{Rails.root}/spec/fixtures/f569f9fd1992c36a6c42c915abbd924c_w.jpeg"
      fill_in 'drink[name]', with: @drink.name
      fill_in 'drink[alc_percent]', with: @drink.alc_percent
      fill_in 'drink[description]', with: @drink.description
      fill_in 'drink[combo]', with: @drink.combo
      select 'カクテル', from: 'drink[genre_id]'
      select '甘口', from: 'drink[sweet_dry_id]'
      select '★★★★☆', from: 'drink[recommendation_id]'
      select '特別な日', from: 'drink[best_time_id]'
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Drink.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど乾杯した内容が存在することを確認する
      expect(page).to have_content(@drinks)
    end
  end

  context '乾杯ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      visit new_drink_path
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

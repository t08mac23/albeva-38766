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


RSpec.describe '投稿の編集', type: :system do
  before do
    @drink1 = FactoryBot.create(:drink)
    @drink2 = FactoryBot.create(:drink)
  end
  context '投稿内容が編集ができるとき' do
    it 'ログインしたユーザーは自分が乾杯した投稿を編集できる' do
      # 乾杯1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'email', with: @drink1.user.email
      fill_in 'password', with: @drink1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 乾杯1の詳細ページへ遷移する
      visit drink_path(@drink1)
      # 編集ページへ遷移する
      visit edit_drink_path(@drink1)
      # 投稿内容を編集する
      # fill_in 'drink[name]', with: @drink2.name
      fill_in 'drink[description]', with: @drink2.description
      # 編集してもdrinkモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Drink.count }.by(0)
      # 編集完了し詳細ページに遷移したことを確認する
      expect(current_path).to eq(drink_path(@drink1))
      # 詳細ページには先ほど変更した内容が存在することを確認する
      # expect(page).to have_content(@drink2.name)
      expect(page).to have_content(@drink2.description)
    end
  end
  context '編集ができないとき' do
    it 'ログインしたユーザーは自分以外が乾杯した投稿の編集画面には遷移できない' do
      # 乾杯1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'email', with: @drink1.user.email
      fill_in 'password', with: @drink1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 乾杯2に「編集」へのリンクがないことを確認する
      visit drink_path(@drink2)
      expect(page).to have_no_link '編集', href: edit_drink_path(@drink2)
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 乾杯1に「編集」へのリンクがないことを確認する
      visit drink_path(@drink1)
      expect(page).to have_no_link '編集', href: edit_drink_path(@drink1)
      # 乾杯2に「編集」へのリンクがないことを確認する
      visit drink_path(@drink2)
      expect(page).to have_no_link '編集', href: edit_drink_path(@drink2)
    end
  end
end


RSpec.describe '投稿の削除', type: :system do
  before do
    @drink1 = FactoryBot.create(:drink)
    @drink2 = FactoryBot.create(:drink)
  end
  context '投稿内容が削除ができるとき' do
    it 'ログインしたユーザーは自分が乾杯した投稿を削除できる' do
      # 乾杯1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'email', with: @drink1.user.email
      fill_in 'password', with: @drink1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 乾杯1の詳細ページへ遷移する
      visit drink_path(@drink1)
      # 乾杯1に「削除」へのリンクがあることを確認する
      expect(page).to have_content '削除'
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        first(:link, '削除').click
      }.to change { Drink.count }.by(-1)
      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(drink_path(@drink1))
      # 「削除が完了しました」の文字があることを確認する
      expect(page).to have_content('乾杯が削除されました')
      # トップページに遷移する
      visit root_path
      # トップページには乾杯1の内容が存在しないことを確認する
      expect(page).to have_no_content(@drink1)
    end
  end
  context '削除ができないとき' do
    it 'ログインしたユーザーは自分以外が乾杯した投稿の編集画面には遷移できない' do
      # 乾杯1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'email', with: @drink1.user.email
      fill_in 'password', with: @drink1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 乾杯2に「削除」へのリンクがないことを確認する
      visit drink_path(@drink2)
      expect(page).to have_no_link '削除', href: edit_drink_path(@drink2)
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 乾杯1に「削除」へのリンクがないことを確認する
      visit drink_path(@drink1)
      expect(page).to have_no_link '削除', href: edit_drink_path(@drink1)
      # 乾杯2に「削除」へのリンクがないことを確認する
      visit drink_path(@drink2)
      expect(page).to have_no_link '削除', href: edit_drink_path(@drink2)
    end
  end
end
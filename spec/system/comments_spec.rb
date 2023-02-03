require 'rails_helper'

RSpec.describe "Comments", type: :system do

  before do
    @drink1 = FactoryBot.create(:drink)
    @comment = FactoryBot.build(:comment)
  end

  it 'ログインしたユーザーは投稿の詳細ページでコメント投稿できる' do
    # ログインする
    sign_in(@user)
    # 投稿の詳細ページに遷移する
    visit drink_path(@drink1)
    # フォームに情報を入力する
    fill_in 'comment[text]', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(drink_path(@drink1))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end

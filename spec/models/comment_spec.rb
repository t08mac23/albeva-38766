require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿の保存' do
    context 'コメント投稿が正しくできる場合' do
      it '全ての項目を正しく記入した場合' do
        expect(@comment).to be_valid
      end
    end
    context 'コメントができない場合' do
      it 'コメントが空欄では保存できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
    end
  end
end

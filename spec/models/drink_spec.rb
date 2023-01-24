require 'rails_helper'

RSpec.describe Drink, type: :model do
  before do
    @drink = FactoryBot.build(:drink)
  end

  describe '投稿の保存' do
    context '乾杯が正しくできる場合' do
      it '全ての項目を正しく記入した場合' do
        expect(@drink).to be_valid
      end

      it 'おつまみの欄は空でも保存できる' do
        @drink.combo = ''
        expect(@drink).to be_valid
      end

      it 'ベストタイムの欄は未選択でも保存できる' do
        @drink.best_time_id = 1
        expect(@drink).to be_valid
      end
    end

    context '乾杯ができない場合' do
      it 'imageが空では登録できないこと' do
        @drink.image = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では登録できないこと' do
        @drink.name = ''
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Name can't be blank")
      end

      it 'アルコール度数が空では登録できないこと' do
        @drink.alc_percent = ''
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Alc percent is not a number")
      end

      it 'アルコール度数が文字では登録できないこと' do
        @drink.alc_percent = '十三'
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Alc percent is not a number")
      end

      it 'アルコール度数に小数点は登録できないこと' do
        @drink.alc_percent = '15.5'
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Alc percent must be an integer")
      end

      it 'アルコール度数に全角数字では登録できないこと' do
        @drink.alc_percent = '２１'
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Alc percent is not a number")
      end

      it '説明が空では登録できないこと' do
        @drink.description = ''
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Description can't be blank")
      end

      it 'ジャンルが未選択では登録できないこと' do
        @drink.genre_id = 1
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Genre can't be blank")
      end

      it 'テイストが未選択では登録できないこと' do
        @drink.sweet_dry_id = 1
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Sweet dry can't be blank")
      end

      it 'おすすめ度が未選択では登録できないこと' do
        @drink.recommendation_id = 1
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Recommendation can't be blank")
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @drink.user = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('User must exist')
      end
    end
  end
end

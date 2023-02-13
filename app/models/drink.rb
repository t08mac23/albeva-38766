class Drink < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :favorites, dependent: :destroy

    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end

    def self.search(search)
      if search != ""
        Drink.where('name LIKE(?)', "%#{search}%")
      else
        Drink.all
      end
    end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :sweet_dry
  belongs_to :recommendation
  belongs_to :best_time

  with_options presence: true do
    validates :image, :name, :description
  end

  validates  :alc_percent, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
                      presence: { message: "を入力してください" }

  validates :genre_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :sweet_dry_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :recommendation_id, numericality: { other_than: 1, message: "can't be blank" }
end

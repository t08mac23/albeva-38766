class Drink < ApplicationRecord

  belongs_to :user
  has_one_attached :image

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

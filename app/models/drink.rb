class Drink < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  validates :genre_id, numericality: { other_than: 1, message: "can't be blank" }
end

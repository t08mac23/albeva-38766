class Drink < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :sweet_dry

  validates :genre_id, numericality:     { other_than: 1, message: "can't be blank" }
  validates :sweet_dry_id, numericality: { other_than: 1, message: "can't be blank" }
end

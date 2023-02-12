class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname,    presence: :true, length: { maximum: 30 }
         validates :password,    format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze }

         has_many :drinks
         has_many :comments
         has_many :favorites, dependent: :destroy
end

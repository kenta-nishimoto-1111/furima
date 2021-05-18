class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  with_options presence: true do

    validates :nickname
    validates :birth_date

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/} do
      validates :first_name
      validates :last_name
    end

    with_options format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/} do
      validates :first_name_kana
      validates :last_name_kana
    end

  end
end
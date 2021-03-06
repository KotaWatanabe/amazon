class User < ApplicationRecord
    has_secure_password
    has_many :news_article, dependent: :nullify
    has_many :product, dependent: :destroy
    has_many :reviews, dependent: :nullify

    validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def full_name
      "#{first_name} #{last_name}".strip
    end
end


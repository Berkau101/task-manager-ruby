class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  # validates :email, presence: true,
  # uniqueness: true,
  # format: { with: URI::MailTo::EMAIL_REGEXP, message: "geçerli bir e-posta olmalı" }
end

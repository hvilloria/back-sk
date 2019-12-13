class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
end

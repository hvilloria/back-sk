class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :validatable, :confirmable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
end

class User < ApplicationRecord
  has_many :orders, foreign_key: 'client_id'
  validates :name, presence: true
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  phone_number           :string
#  name                   :string           not null
#  address                :string
#  birthdate_date         :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  tokens                 :json
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
end

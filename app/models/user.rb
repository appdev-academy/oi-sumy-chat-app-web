class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :messages, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, uniqueness: true

  def jwt_token
    JWT.encode({ id: self.id, issued_at: Time.current.to_i }, Rails.application.credentials.jwt_token)
  end
end

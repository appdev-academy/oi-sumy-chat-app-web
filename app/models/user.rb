class User < ApplicationRecord
  before_validation :set_username, on: :create

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :messages, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, uniqueness: true

  def jwt_token
    JWT.encode({ id: self.id, issued_at: Time.current.to_i }, Rails.application.credentials.jwt_secret)
  end

  def self.generate_username
    [Faker::Adjective.positive, Faker::Creature::Animal.name].join(' ').titleize
  end

  private

  def set_username
    self.username = User.generate_username
  end
end

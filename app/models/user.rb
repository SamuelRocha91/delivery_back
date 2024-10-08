class User < ApplicationRecord
  include Discard::Model
  after_discard :discard_associated_stores
  has_many :stores
  has_many :refresh_tokens
  validates :role, presence: true
  before_discard :anonymize_email
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :addresses, as: :addressable
  enum :role, [:admin, :seller, :buyer, :developer]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  class InvalidToken < StandardError; end

  def active_for_authentication?
    super && !discarded?
  end

  def self.token_for(user)
    jwt_secret_key = ENV['JWT_SECRET_KEY']
    jwt_headers = {exp: 1.hour.from_now.to_i}
    payload = {
      id: user.id,
      email: user.email,
      role: user.role
    }
    JWT.encode(
      payload.merge(jwt_headers),
      jwt_secret_key,
      "HS256"
    )
  end

  def self.from_token(token)
    jwt_secret_key = ENV['JWT_SECRET_KEY']
    jwt_decode = (JWT.decode token, jwt_secret_key, true, { algorithm: 'HS256'})
      .first
      .with_indifferent_access
    jwt_decode
  rescue JWT::ExpiredSignature
    raise InvalidToken.new
  end

  def developer?
    role == 'developer'
  end
  
  private

  def discard_associated_stores
    stores.each do |store|
      store.discard
      store.products.each(&:discard)
    end
  end

  def anonymize_email
    domain = email.split('@').last
    self.email = "anon_#{id}@#{domain}"
  end
end

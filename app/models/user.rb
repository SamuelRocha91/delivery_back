class User < ApplicationRecord
  has_many :stores

  enum :role, [:admin, :seller, :buyer]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

class User < ApplicationRecord
  has_many :stores

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

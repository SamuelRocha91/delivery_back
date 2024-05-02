class Credential < ApplicationRecord
  enum :access, [:seller, :buyer]
end

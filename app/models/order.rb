class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :store
end

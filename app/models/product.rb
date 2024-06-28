class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders, dependent: :destroy
end

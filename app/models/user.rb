class User < ApplicationRecord
  has_secure_password

  has_one :buyer
  has_one :seller
  has_one :cart, dependent: :destroy

  after_create :create_cart

  def seller?
    seller.present?
  end

  def buyer?
    buyer.present?
  end

  def create_cart
    Cart.create(user: self)
  end
end

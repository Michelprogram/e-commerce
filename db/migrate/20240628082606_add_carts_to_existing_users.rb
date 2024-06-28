class AddCartsToExistingUsers < ActiveRecord::Migration[7.1]
  def up
    User.find_each do |user|
      user.create_cart
    end
  end

  def down
    Cart.delete_all
  end
end

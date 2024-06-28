module CartsHelper
  def cart_item_count
    if logged_in?
      current_user.cart.cart_items.sum(:quantity)
    else
      0
    end
  end
end

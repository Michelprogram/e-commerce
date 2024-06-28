class OrdersController < ApplicationController
  def create
    product = Product.find(params[:order][:product_id])
    quantity = params[:order][:quantity].to_i
    total_price = product.price * quantity

    @order = current_user.buyer.orders.build(product: product, quantity: quantity, total_price: total_price)

    if @order.save
      product.update(stock: product.stock - quantity)
      redirect_to @order.product, notice: 'Order placed successfully'
    else
      redirect_to @order.product, alert: 'Failed to place order'
    end
  end
end

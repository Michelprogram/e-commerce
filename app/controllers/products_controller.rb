class ProductsController < ApplicationController
  before_action :require_user, only: [:index, :new, :create, :edit, :update, :destroy, :my_products]

  def index
    if current_user&.seller
      @products = Product.where.not(seller: current_user.seller)
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = current_user.seller.products.build
  end

  def create
    @product = current_user.seller.products.build(product_params)
    if @product.save
      redirect_to @product, notice: 'Product created successfully'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: 'Product deleted successfully'
  end

  def my_products
    @products = current_user.seller.products
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end

  def require_seller
    unless current_user&.seller
      redirect_to root_path, alert: 'Only sellers can perform this action'
    end
  end
end

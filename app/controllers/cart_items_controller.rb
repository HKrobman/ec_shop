class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    @cart_item = @cart.add_product(product.id, quantity)
    @cart_item.save
    redirect_to current_cart
  end
end
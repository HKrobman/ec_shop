class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "products"                           
      @cart_item = @cart.add_product(product.id, quantity)
    elsif path[:controller] == "carts"
      @cart_item = @cart.change_count(product.id, quantity)
    else
      @cart_item = @cart.push_favorite_product(product.id)
    end
    @cart_item.save
    redirect_to current_cart
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_path(current_user)
  end
  
end
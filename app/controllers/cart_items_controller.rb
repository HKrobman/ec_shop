class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :create]
  def create
    @cart_item = current_cart.add_product(@product.id, @quantity)
    if @cart_item.save
      redirect_to current_cart
    else
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_path(current_user)
  end
  
  def update
    @cart_item = current_cart.change_count(@product.id, @quantity)
    @cart_item.save
    redirect_to current_cart
  end
  
  def set_cart_item
    @product = Product.find(params[:product_id])
    @quantity = params[:quantity].to_i
  end
end
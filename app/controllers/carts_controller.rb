class CartsController < ApplicationController
   
  def show
    @cart_items = current_cart.cart_items.all.page(params[:page]).per(4)
  end

  def destroy
    current_cart.destroy
    redirect_to cart_path(current_cart)
  end
  
  
  
  def total_price
    cart_items.to_a.sum{ |item| item.total_price }
  end    
  
  
end

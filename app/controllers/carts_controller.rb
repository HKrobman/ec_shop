class CartsController < ApplicationController
    before_action :set_up_cart, only: [:add_items, :update_items, :delete_items]
   
  def show
    @cart_items = current_cart.cart_items
    #binding.pry
  end

  def update_items
    @cart_items.update(quantity: params[:quantity].to_i) 
  
  end
    
  def destroy
    current_cart.destroy
    redirect_to current_cart
  end

  def total_price
    cart_items.to_a.sum{ |item| item.total_price }
  end    
  
  private
    
 # def set_up_cart
#    @cart_items = current_cart.cart_items.find_by(product_id: params[:product_id])
#  end
end

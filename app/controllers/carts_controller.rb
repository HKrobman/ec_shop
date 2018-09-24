class CartsController < ApplicationController
   
  def show
    @cart_items = current_cart.cart_items.all.page(params[:page]).per(4)
  end

  def update_items
    @cart_items.update(quantity: params[:quantity].to_i) 
  
  end
    
  def destroy
    current_cart.destroy
    redirect_to cart_path
  end

  def total_price
    cart_items.to_a.sum{ |item| item.total_price }
  end    
  
  private
    
 # def set_up_cart
#    @cart_items = current_cart.cart_items.find_by(product_id: params[:product_id])
#  end
end

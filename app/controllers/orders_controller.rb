class OrdersController < ApplicationController
    
    def show
    end
    
    def new
      @user = current_user
      #@order = @user.orders.build
      #if @order.save
        #redirect_to action: 'confirm'
      #else
      #  redirect_to new_order_path
      #end
    end
    
    def confirm
      @usr = current_user
    end
    
    def create
    end
    
end
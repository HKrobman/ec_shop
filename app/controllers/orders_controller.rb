class OrdersController < ApplicationController
    
    def show
    end
    
    def new
      @user = current_user
      @order = Order.new(user_id: @user.id)
      binding.pry
    end
    
    def confirm
      @order = Order.new(user_params)
      binding.pry
    end
    
    def create
    end
    
end
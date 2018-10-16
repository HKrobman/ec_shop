class OrdersController < ApplicationController
    
    def index
      @orders = Order.all.page(params[:page]).per(5)
    end
    
    def show
    end
    
    def new
      @user = current_user
      @order = Order.new
    end
    
    def confirm
      @cart_items = current_cart.cart_items.all.page(params[:page]).per(4)
      @order = Order.new(order_params)
    end
    
    def create
      @order = Order.new(order_params)
      @order.add_items(current_cart)
      if params[:credit]
        render :new
      elsif @order.save
        render :accepted
      end        

    end
    
    def accepted
    end
    
    def pay
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
      :amount => 3500,
      :card => params['payjp-token'],
      :currency => 'jpy'
      )
    end
    
    def order_params
      params.require(:order).permit(:addressee_name_kana,:addressee_name_kanji,:addressee_zip_code,
                                     :addressee_prefecture,:addressee_address1,:addressee_address2, :pay_type, :total_price,:user_id)
    end
    
end

=begin

=end
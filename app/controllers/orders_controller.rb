class OrdersController < ApplicationController
    
    def index
      @orders = Order.all.order(created_at: "DESC").page(params[:page])#.per(2)
    end
    
    def show
    end
    
    def new
      if current_cart.cart_items.empty?
        flash[:notice] = "カートに商品を追加してください"
        redirect_to cart_path(current_cart)
      else  
        @user = current_user
        @order = Order.new
        @order.addressee_name_kana = @user.name_kana
        @order.addressee_name_kanji = @user.name_kanji
        @order.order_telphone = @user.telphone
        @order.addressee_zip_code = @user.zip_code
        @order.addressee_prefecture = @user.prefecture
        @order.addressee_city = @user.city
        @order.addressee_address1 = @user.address1
        @order.addressee_address2 = @user.address2
      end
    end
    
    def confirm
      @cart_items = current_cart.cart_items.all.page(params[:page]).per(5)
      @order = Order.new(order_params)
      if @order.pay_type=="現金"
        @cart_total = @cart.total_price + 350 + 400
      else
        @cart_total = @cart.total_price + 350
      end
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
      @order = Order.last
      @deli_date = @order.created_at.since(4.days)
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
      params.require(:order).permit(:addressee_name_kana,:addressee_name_kanji,:addressee_zip_code,:order_telphone,
                                     :addressee_prefecture,:addressee_city,:addressee_address1,:addressee_address2, :pay_type, :total_price,:user_id)
    end
    
end

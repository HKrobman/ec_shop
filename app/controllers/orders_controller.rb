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
        @order = Order.new
        @order.addressee_name_kana = current_user.name_kana
        @order.addressee_name_kanji = current_user.name_kanji
        @order.order_telphone = current_user.telphone
        @order.addressee_zip_code = current_user.zip_code
        @order.addressee_prefecture = current_user.prefecture
        @order.addressee_city = current_user.city
        @order.addressee_address1 = current_user.address1
        @order.addressee_address2 = current_user.address2
      end
    end
    
    def confirm
      @cart_items = current_cart.cart_items.all.page(params[:page]).per(5)
      @order = Order.new(order_params)
      if @order.pay_type=="現金"  #送料350円 + 代引き手数料400円
        @cart_total = @cart.total_price + 350 + 400
      else  #クレカ決済の場合は送料350円のみ
        @cart_total = @cart.total_price + 350
      end
    end
    
    def create
      @order = Order.new(order_params)
      @order.add_items(current_cart)
      if params[:credit]
        render :new
      elsif @order.save
        @order.cart_items.each { |item| item.product.sold! }
        render :accepted
      end        

    end
    
    def accepted
      @order = Order.last
      @deli_date = @order.created_at.since(4.days)    #表示されない
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

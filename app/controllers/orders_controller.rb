class OrdersController < ApplicationController
    
    def index
      @orders = Order.where(user_id: current_user.id)
    end
    
    def show
      @order = Order.find(params[:id])
      @order.status ? @order_status = "発送済み" : @order_status = "未発送"
    end
    
    def new
      if current_cart.cart_items.empty?
        flash[:alert] = "カートに商品を追加してください"
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
      @cart_items.each {|item| item.product.delivery_day(item)}
      wd = ["日", "月", "火", "水", "木", "金", "土"]
      
    #hidden_fieldでdelivery_dateカラムに代入するための変数
      @max_delivery_date = Date.today + $max_day
    #お届け日としてviewに表示するための変数
      @max_delivery_day = @max_delivery_date.strftime("%m/%d(#{wd[@max_delivery_date.wday]})")  
      
      @order = Order.new(order_params)
      render :new unless @order.valid?
      if @order.pay_type=="現金"  #送料350円 + 代引き手数料400円
        @cart_total = @cart.total_price + 350 + 400
      else  #クレカ決済の場合は送料350円のみ
        @cart_total = @cart.total_price + 350
      end
    end
    
    def create
      @order = Order.new(order_params)
      binding.pry
      @order.add_items(current_cart)
      if params[:credit]
        render :new
      elsif @order.save
        @order.cart_items.each { |item| item.product.sold! } #在庫数から購入数を引く
        render :accepted
      else
        redirect_to new_order_path
        flash[:error] = "必要項目を入力してください"
      end        

    end
    
    def accepted
      @order = Order.where(user_id: current_user.id).last
    end
    
    #pay-jpテストモード
    def pay
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
      :amount => 3500,
      :card => params['payjp-token'],
      :currency => 'jpy'
      )
    end
    
private

  def order_params
    params.require(:order).permit(:addressee_name_kana,:addressee_name_kanji,:addressee_zip_code,:order_telphone,
                                  :addressee_prefecture,:addressee_city,:addressee_address1, :pay_type, :total_price,:user_id, :delivery_date)
  end
    
end

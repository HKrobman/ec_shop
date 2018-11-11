class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :create]
  def create
    stock = Stock.find_by(product_id: @product.id)[:sales_quantity]
    @cart_item = current_cart.add_product(@product.id, @quantity)
    redirect_to current_cart
    if @cart_item.quantity > 10
      flash[:alert] = "一度に購入できる同一商品は10個までです。"
    elsif @cart_item.quantity > stock
      flash[:alert] = "この商品の在庫は#{stock}個です。"
    else
      if @cart_item.save
        flash[:success] = "商品を追加しました。"
      else
        flash[:alert] = "エラーが発生しました。"
      end
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to cart_path(current_user)
    else
      flash[:alert] = "エラーが発生しました。"
    end
  end
  
  def update
    stock = Stock.find_by(product_id: @product.id)[:sales_quantity]
    @cart_item = current_cart.change_count(@product.id, @quantity)
    redirect_to current_cart
    #カート内商品個数が在庫数以上になってしまった場合の処理
    if stock < @cart_item.quantity
      flash[:alert] = "この商品の在庫は#{stock}個です。"
    else  
      @cart_item.save
      flash[:success] = "商品個数を変更しました。"
    end
  end
  
  def set_cart_item
    @product = Product.find(params[:product_id])
    @quantity = params[:quantity].to_i
  end
end
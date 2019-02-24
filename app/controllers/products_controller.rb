class ProductsController < ApplicationController
  before_action :set_product, only: :show
    
    def index
       @categories = Category.all
       product = if params[:category_id]
                   Product.where(category_id: params[:category_id])
      #ページ上部検索ボックスでカテゴリー指定&ワード入力で検索した場合
                 elsif params[:category]&.any?(&:present?) && params[:search] 
                   Product.search(params[:search]).where(category_id: params[:category])
      #ページ上部検索ボックスでカテゴリー未指定&ワードのみを入力して検索した場合 
                 elsif params[:search] 
                   Product.search(params[:search])
                 else                                              
                   Product.all
                 end
                 
      @products = product.order(created_at: :desc).page(params[:page]).per(8)
      flash.now[:notice] = " 検索条件に一致する商品は見つかりませんでした。" if product.empty?
    end
    
    def show
      stock = Stock.find_by(product_id: params[:id])[:sales_quantity]
      #在庫数が10個以下の場合はnumber_fieldで選択できる値を在庫数分だけにする(一度に注文できる個数は10個まで)
      stock < 10 ? @max = stock : @max = 10
      @stock = judge_status(stock)
      
      #review.rbにてdefault_scope -> {order('created_at DESC')}に指定しているため
      #lastではなくfirstメソッドを利用し最新のレビューを取得している(改善の余地あり。)
      @last_review = @product.reviews.first
      
      @review_rank = @product.reviews.average(:rank)
      @product_description = @product.description.split("\r\n")
      
      wd = ["日", "月", "火", "水", "木", "金", "土"]
      time = Date.today + @product.delivery_days
      @delivery_days = time.strftime("%m/%d(#{wd[time.wday]})")
      
     #該当商品がマイリストに登録されているかを確認。
      if signed_in?
        @mylist = Mylist.find_by(user_id: current_user.id, product_id: params[:id])
      end
    end

private
    
  def set_product
    @product = Product.find(params[:id])
  end
    
  def judge_status(stock)
    stock > 20 ? "あり" : "残りわずか"
  end
  
end

 

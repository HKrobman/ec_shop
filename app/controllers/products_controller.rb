class ProductsController < ApplicationController
  before_action :set_product, only: :show
    
    def index
      product = if params[:category_id]
                   Product.where(category_id: params[:category_id])
                else
                   Product.all
                end
      @products = product.order(created_at: :desc).page(params[:page]).per(8)
    end
    
    def show
      user = current_user
      stock = Stock.find_by(product_id: params[:id])[:sales_quantity]
      @stock = judge_status(stock)
       @current_stock_array = []
        stock.times do |quantity|
          if quantity < 10
            @current_stock_array << [quantity + 1, quantity + 1]
          else
            break
          end
        end
      @review = Review.last
      @mylist = Mylist.find_by(user_id: user.id, product_id: params[:id])
    end
    
    def create
    end
    
    def update
    end
    
    private
    
    def set_product
      @product = Product.find(params[:id])
    end
    
        
  def judge_status(stock)
    if stock > 20
      "あり"
    else
      "残りわずか"
    end
  end

end

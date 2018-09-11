class ProductsController < ApplicationController
    
    def index
        if params[:category_id]
            @products = Product.where(category_id: params[:category_id]).page(params[:page]).per(8)
        else
            @products = Product.all.order(created_at: :desc).page(params[:page]).per(8)
        end
    end
    
    def show
        @product = Product.find(params[:id])
        @reviews = Review.find_by(id: 1)  #test
    end
    
    def create
       @products = Product.new
    end
    
    def update
    end
    
end

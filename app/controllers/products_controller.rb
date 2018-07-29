class ProductsController < ApplicationController
    def index
        @products = Product.all
    end
    def show
        @products = Product.find(params[:id])
    end
    
    def create
        @products = Product.new
    end
end

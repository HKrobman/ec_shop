class MylistsController < ApplicationController
    before_action :authenticate_user!
    byebug
    def index
        user = current_user
        @mylists = Mylist.where(user_id: user.id).all
    end
    
    def show
        
    end
    
    def create
        user = current_user
        product = Product.find(params[:product_id])
        if Mylist.create(user_id: user.id, product_id: product.id)
            redirect_to products_path 
        else
            redirect_to products_path 
        end
    end
    
    def destroy
        user = current_user
        product = Product.find(params[:product_id])
        if mylist = Mylist.find_by(user_id: user.id, product_id: product.id)
            mylist.delete
            redirect_to products_path #仮
        else
            redirect_to products_path #仮
        end
    end

end

class MylistsController < ApplicationController
    before_action :authenticate_user!
    def index
        user = current_user
        @mylists = Mylist.where(user_id: user.id).page(params[:page]).per(5)
    end
    
    def show
        @mylists = Mylist.where(user_id: params[:id]).page(params[:page]).per(5)
    end
    
    def create
        user = current_user  
        product = Product.find(params[:product_id])
        @mylist = Mylist.create(user_id: user.id, product_id: product.id)
        @mylist.save
        redirect_to product_path(params[:product_id])
    end
    
    def destroy
        user = current_user  
        #@mylist = Mylist.find(params[:id])
        product = Product.find(params[:product_id])
        @mylist = Mylist.find_by(user_id: user.id, product_id: product.id)
        @mylist.destroy
        redirect_to mylists_path(current_user)
    end

end

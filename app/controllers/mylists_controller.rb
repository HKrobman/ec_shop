class MylistsController < ApplicationController
    before_action :authenticate_user!
    def index
        @mylists = Mylist.where(user_id: current_user.id).order(created_at: "DESC")
    end
    
    def show
        @mylists = Mylist.where(user_id: params[:id]).page(params[:page]).per(5)
    end
    
    def create
        product = Product.find(params[:product_id])
        @mylist = Mylist.create(product_id: product.id, user_id: current_user.id)
        binding.pry
        @mylist.save
        flash[:notice] = "マイリストに追加しました"
        redirect_to product_path(params[:product_id])
    end
    
    def destroy
        @mylist = Mylist.find(params[:id])
        @mylist.destroy
        redirect_to mylists_path(current_user)
        flash[:notice] = "マイリストから削除しました"
    end

end

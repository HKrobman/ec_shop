class MylistsController < ApplicationController
    before_action :authenticate_user!
    def index
        @mylists = Mylist.where(user_id: current_user.id).order(created_at: "DESC").page(params[:page]).per(5)
    end
    
    def show
        @mylists = Mylist.where(user_id: params[:id]).page(params[:page]).per(5)
    end
    
    def create
        product = Product.find(params[:product_id])
        @mylist = Mylist.create(user_id: current_user.id, product_id: product.id)
        @mylist.save
        flash[:notice] = "マイリストに追加しました"
        redirect_to product_path(params[:product_id])
    end
    
    def destroy
        product = Product.find(params[:product_id])
        @mylist = Mylist.find_by(user_id: current_user.id, product_id: product.id)
        @mylist.destroy
        flash[:notice] = "マイリストから削除しました"
        redirect_to product_path(params[:product_id])
    end

end

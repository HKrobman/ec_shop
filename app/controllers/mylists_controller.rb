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
    @mylist = Mylist.new(product_id: product.id, user_id: current_user.id)
    if @mylist.save
      flash[:success] = "マイリストに追加しました"
      redirect_to product_path(params[:product_id])
    else
      flash[:alert] = "エラーが発生しました。"
      redirect_to product_path(params[:product_id])
    end
  end
    
    
  def destroy
    @mylist = Mylist.find(params[:id])
     if @mylist.destroy
       redirect_to mylists_path(current_user)
       flash[:alert] = "マイリストから削除しました"
     else
       redirect_to mylists_path(current_user)
       flash[:alert] = "エラーが発生しました。"
     end
  end

end

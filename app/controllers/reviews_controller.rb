class ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @reviews = Review.where(product_id: params[:product_id]).page(params[:page]).order(created_at: "DESC").per(6)
    @review_rank = @reviews.average(:rank)
  end
  
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end
  
  def edit   
    binding.pry
    #@product = Product.find(params[:id])
    @review = Review.find(params[:id]) 
=begin    
    @review.rank = @review.rank 
    @review.name = @review.name
    @review.title = @review.title
    @review.description = @review.description
=end
  end
  
  
  def update
    review = Review.find(@review)
    @revi
=begin
    @review = Review.new(
      rank: review_params[:rank].to_i,
      name: review_params[:name],
      title: review_params[:title],
      description: review_params[:description],
      user_id: current_user.id,
      product_id: params[:product_id]
     )
     redirect_to reviews_path(product_id: params[:product_id])  if @review.save 
=end
  end


  def show
   @review = Review.find(params[:id])
  end

  
  def create
    @review = Review.new(
      rank: review_params[:rank].to_i,
      name: review_params[:name],
      title: review_params[:title],
      description: review_params[:description],
      user_id: current_user.id,
      product_id: params[:product_id]
      )
    binding.pry
    redirect_to product_path(params[:product_id])  if @review.save   
  end
  
  def destroy
    review = Review.find(params[:id])
    if review.destroy
      redirect_to reviews_path(product_id: review.product_id)
      flash[:notice] = "レビューを削除しました。"
    else
      redirect_to reviews_path(product_id: review.product_id) 
      flash[:notice] = "エラーが発生しました。"
    end
  end
  
   private

    def review_params
      params.require(:review).permit(:rank, :name, :title, :description, :product_id, :user_id)
    end
end

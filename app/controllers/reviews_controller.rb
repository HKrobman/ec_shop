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
  
  def edit   #未実装
    @product = Product.find(params[:product_id])
    review = Review.find_by(product_id: @product.id, user_id: current_user.id) 
    @review.rank = review.rank 
    @review.name = review.name
    @review.title = review.title
    @review.description = review.description
  end
  
  
  def update
    @review = Review.new(
      rank: review_params[:rank].to_i,
      name: review_params[:name],
      title: review_params[:title],
      description: review_params[:description],
      user_id: current_user.id,
      product_id: params[:product_id]
     )
     redirect_to reviews_path(product_id: params[:product_id])  if @review.save 
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
    redirect_to product_path(params[:product_id])  if @review.save   
  end
  
   private

    def review_params
      params.require(:review).permit(:name, :title, :description, :rank, :product_id)
    end
end

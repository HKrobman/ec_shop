class ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @reviews = Review.where(product_id: params[:product_id]).page(params[:page]).per(6)
  end
  
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

#必要?
  def show
   @reviews = Review.find(product_id: params[:product_id]).page(params[:page]).per(6)
  end
#必要?
  
  def create
    user = current_user
    @review = Review.new(
      rank: review_params[:rank],
      name: review_params[:name],
      title: review_params[:title],
      description: review_params[:description],
      user_id: user.id,
      product_id: params[:product_id]
    )
    binding.pry
    redirect_to product_path(params[:product_id])  if @review.save   #
  end
  
   private

    def review_params
      params.require(:review).permit(:name, :title, :description, :rank, :product_id)
    end
end

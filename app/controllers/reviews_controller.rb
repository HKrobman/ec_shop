class ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    
    @reviews = Review.all
  end
  
  def new
    @review = Review.new
  end

  def show
   
  end
  
  def create
    @product = Product.find(params[:id])
    @review = Review.new(review_params)
    @review.product_id = @producs.id
  end
  
   private

    def review_params
      params.require(:review).permit(:name, :title, :description)
    end
end
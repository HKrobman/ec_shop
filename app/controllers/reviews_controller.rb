class ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @reviews = Review.where(product_id: params[:product_id]).page(params[:page]).order(created_at: "DESC").per(6)
    @review_rank = @reviews.average(:rank)
  end
  
  
  def show
      @review = Review.find(params[:id])
  end

  
  def new
    @review = Review.new
    @review.product_id = params[:product_id] 
  end
  
  def edit   
    @review = Review.find(params[:id]) 
  end
  
  
  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = "レビューを編集しました。"
      redirect_to @review
    else
      redirect_to edit_review_path(@review)
      flash[:alert] = "入力項目をお確かめください"
    end
  end


  
  def create
    @review = Review.new(review_params)
    if @review.save   
      redirect_to product_path(@review.product_id)  
    else
      render :new
    end
  end
  
  def destroy
    review = Review.find(params[:id])
    if review.destroy
      redirect_to reviews_path(product_id: review.product_id)
      flash[:alert] = "レビューを削除しました。"
    else
      redirect_to reviews_path(product_id: review.product_id) 
      flash[:error] = "エラーが発生しました。"
    end
  end
  
private

  def review_params
    params.require(:review).permit(:rank, :name, :title, :description, :product_id ,:user_id)
  end
end

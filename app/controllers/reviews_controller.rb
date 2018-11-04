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
    #@product = Product.find(params[:product_id])
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
    #binding.pry
    @review = Review.find(params[:id])
=begin
    @review = Review.find(params[:id])
    @review.rank = params[:rank].to_i
    @review.name = params[:name]
    @review.title = params[:title]
    @review.description = params[:description]
=end
    if @review.update_attributes(review_params)
      flash[:success] = "レビューを編集しました。"
      redirect_to @review
    else
      redirect_to edit_review_path(@review)
      flash[:alert] = "入力項目をお確かめください"
    end
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


  
  def create
    @review = Review.new(
      rank: review_params[:rank].to_i,
      name: review_params[:name],
      title: review_params[:title],
      description: review_params[:description],
      user_id: current_user.id,
      product_id: params[:product_id]
      )
    if @review.save   
      redirect_to product_path(params[:product_id])  
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
      params.require(:review).permit(:rank, :name, :title, :description, :product_id, :user_id)
    end
end

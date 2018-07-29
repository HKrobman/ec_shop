class ReviewsController < ApplicationController
    
  def index 
      @reviews = Review.all
  end

  def show
      @reviews = Review.find(params[:id])
  end
  
  def create
      @reviews = Review.find(params[:id])
  end
  
end
class LikesController < ApplicationController
  
  def create
    like = Like.new(user_id: current_user.id, review_id: params[:review_id])
    if like.save
      redirect_back(fallback_location: reviews_path)
    else
      redirect_back(fallback_location: reviews_path)
      flash[:alert] = "エラーが発生しました。"
    end
  end
  
  def destroy
    like = Like.find_by(user_id: current_user.id, review_id: params[:id])
    if like.destroy
      redirect_back(fallback_location: reviews_path)
    else
      redirect_back(fallback_location: reviews_path)
      flash[:alert] = "エラーが発生しました。"
    end
  end
  
end

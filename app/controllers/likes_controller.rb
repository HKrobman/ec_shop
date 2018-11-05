class LikesController < ApplicationController
  
  def create
    like = Like.new(user_id: current_user.id, review_id: params[:review_id])
    if like.save
      redirect_back(fallback_location: reviews_path)
    else
      #例外処理
    end
  end
  
  def destroy
    like = Like.find_by(user_id: current_user.id, review_id: params[:id])
    if like.destroy
      redirect_back(fallback_location: reviews_path)
    else
      #例外処理
    end
  end
  
end

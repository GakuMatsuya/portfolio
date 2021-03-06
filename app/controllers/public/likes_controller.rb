class Public::LikesController < ApplicationController
  
  def create
    review = Review.find(params[:id])
    item = review.item_id
    Like.create(user_id: current_user.id, review_id: params[:id])
    redirect_to item_path(item)
  end
  
  def destroy
    review = Review.find(params[:id])
    item = review.item_id
    Like.find_by(user_id: current_user.id, review_id: params[:id]).destroy
    redirect_to item_path(item)
  end

end

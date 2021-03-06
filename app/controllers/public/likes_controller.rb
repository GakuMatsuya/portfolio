class Public::LikesController < ApplicationController

  def create
    @review = Review.find(params[:id])
    like = current_user.likes.build(review_id: params[:id])
    like.save
  end

  def destroy
    @review = Review.find(params[:id])
    like = Like.find_by(user_id: current_user.id, review_id: params[:id])
    like.destroy
  end

end

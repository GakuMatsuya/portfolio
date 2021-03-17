class Public::LikesController < ApplicationController

  def create
    @user = current_user
    @review = Review.find(params[:id])
    like = current_user.likes.build(review_id: params[:id])
    like.save
  end

  def destroy
    @user = current_user
    @review = Review.find(params[:id])
    like = Like.find_by(user_id: current_user.id, review_id: params[:id])
    like.destroy
  end

end

class Public::LikesController < ApplicationController
  def create
    @user = current_user
    @review = Review.find(params[:id])
    like = current_user.likes.build(review_id: params[:id])
    if like.save
      flash[:notice] = "いいねしました"
    end
    # 画面更新でflashメッセージを非表示に
    flash.discard
  end

  def destroy
    @user = current_user
    @review = Review.find(params[:id])
    like = Like.find_by(user_id: current_user.id, review_id: params[:id])
    if like.destroy
      flash[:notice] = "いいねを解除しました"
    end
    flash.discard
  end
end

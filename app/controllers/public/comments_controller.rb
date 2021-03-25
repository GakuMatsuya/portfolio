class Public::CommentsController < Public::ApplicationController

  def create
    review = Review.find(params[:comment][:review_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.review_id = review.id
    comment.text = params[:comment][:text]
    if comment.save
      flash[:notice] = "コメントしました"
      redirect_to item_review_path(review.item_id, review)
    else
      flash[:alert] = "コメントに失敗しました"
      redirect_to item_review_path(review.item_id, review)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:notice] = "コメントを削除しました"
      redirect_to item_review_path(comment.review.item_id, comment.review_id)
    else
      flash[:alert] = "削除に失敗しました"
      redirect_to item_review_path(comment.review.item_id, comment.review_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :item_id, :review_id, :user_id)
  end

end

class Public::CommentsController < Public::ApplicationController

  def create
    review = Review.find(params[:comment][:review_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.review_id = review.id
    comment.text = params[:comment][:text]
    comment.save
    redirect_to item_review_path(review.item_id, review)
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:text)
  end

end

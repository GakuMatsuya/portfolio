class Public::CommentsController < Public::ApplicationController
  def create
    @review = Review.find(params[:comment][:review_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.review_id = @review.id
    @comment.text = params[:comment][:text]
    @comments = @review.comments.includes([:user])
    if @comment.save
      flash[:notice] = "コメントしました"
      render :index
    else
      flash[:alert] = "コメントに失敗しました"
      render :index
    end
    flash.discard
  end

  def destroy
    @review = Review.find(params[:review_id])
    @comment = Comment.find(params[:id])
    @comments = @review.comments.includes([:user])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました"
      render :index
    else
      flash[:alert] = "削除に失敗しました"
      render :index
    end
    flash.discard
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :item_id, :review_id, :user_id)
  end
end

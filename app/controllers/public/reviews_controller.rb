class Public::ReviewsController < Public::ApplicationController

  def new
    @review = Review.new
  end

  def create
    @item = Item.find(params[:item_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.item_id = @item.id
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  #reviewはitemの情報も持っているため、itemに紐付いたreviewに紐付いたコメントが作成できる
  def show
    @review = Review.find(params[:id])
    @comment = Comment.new(review_id: @review.id)
  end

  def edit
    @review = Review.find(params[:id])
    @user = @review.user_id
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "変更内容を保存しました"
      redirect_to item_review_path(@review.item_id, @review)
    else
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice] = "レビューを削除しました"
    redirect_to user_path(review.user_id)
  end

  private

  def review_params
    params.require(:review).permit(:rate, :text)
  end

end

class Public::ReviewsController < Public::ApplicationController

  def new
    @review = Review.new
  end

  def create
    @item = Item.find(params[:item_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.item_id = @item.id
    @review.save
    redirect_to item_path(@item)
  end

  def index
  end

  def show
    @review = Review.find(params[:id])
    @item = @review.item.id
    @comment = Comment.new
  end

  def edit
  end

  def like
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:rate, :text)
  end

end

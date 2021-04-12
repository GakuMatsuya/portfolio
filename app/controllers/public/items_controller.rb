class Public::ItemsController < Public::ApplicationController
  before_action :set_q, only: [:index, :search]

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews.includes(:user, :tags).page(params[:page]).per(5)
    @average_review = @item.review_average
  end

  # 定義したメソッドを呼び出し
  def index
    @items = Item.count_and_average_reviews.all.page(params[:page]).per(5)
  end

  def search
    @items = @q.result
  end

  private

  # パラメータを元にテーブルからデータを検索
  def set_q
    @q = Item.count_and_average_reviews.all.ransack(params[:q])
  end
end

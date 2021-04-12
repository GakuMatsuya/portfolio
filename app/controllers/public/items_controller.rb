class Public::ItemsController < Public::ApplicationController
  before_action :set_q, only: [:index, :search]

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews.includes(:user, :tags).page(params[:page]).per(5)
    @average_review = @item.review_average
  end

  # itemテーブルにreviewテーブルを結合
  def index
    @items = Item.all.left_joins(:reviews).group(:id).select('items.*, count(reviews.item_id) as count, avg(reviews.rate) as average').page(params[:page]).per(5)
  end

  def search
    @items = @q.result
  end

  private

  # パラメータを元にテーブルからデータを検索
  def set_q
    @q = Item.all.left_joins(:reviews).group(:id).select("items.*, count(reviews.item_id) as count, avg(reviews.rate) as average").ransack(params[:q])
  end
end

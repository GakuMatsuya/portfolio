class Public::ItemsController < Public::ApplicationController
  before_action :set_q, only: [:index, :search]

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews.includes(:user)

    #レビューがあれば平均を、なければ0を
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rate).round(1)
    end
  end

  #itemテーブルにreviewテーブルを
  def index
    @items = Item.all.left_joins(:reviews).group(:id).select("items.*, count(reviews.item_id) as count, avg(reviews.rate) as average")
  end

  def search
    @items = @q.result
  end

  private

  #パラメータを元にテーブルからデータを検索
  def set_q
    @q = Item.all.left_joins(:reviews).group(:id).select("items.*, count(reviews.item_id) as count, avg(reviews.rate) as average").ransack(params[:q])
  end

end

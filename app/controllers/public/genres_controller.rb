class Public::GenresController < Public::ApplicationController
  before_action :set_q

  def show
    @genre = Genre.find(params[:id])
    @items = Item.all.left_joins(:reviews).group(:id).select('items.*, count(reviews.item_id) as count, avg(reviews.rate) as average').where(genre_id: @genre.id).page(params[:page]).per(5)
  end

  def search
    @items = @q.result
    @genre = Genre.find(params[:genre_id])
  end

  private

  # パラメータを元にデータを検索、@qに格納
  def set_q
    @q = Item.all.left_joins(:reviews).group(:id).select("items.*, count(reviews.item_id) as count, avg(reviews.rate) as average").ransack(params[:q])
  end
end

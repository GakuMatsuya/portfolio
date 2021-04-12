class Public::GenresController < Public::ApplicationController
  before_action :set_q

  def show
    @genre = Genre.find(params[:id])
    @items = Item.count_and_average_reviews.all.where(genre_id: @genre.id).page(params[:page]).per(5)
  end

  def search
    @items = @q.result
    @genre = Genre.find(params[:genre_id])
  end

  private

  # パラメータを元にデータを検索、@qに格納
  def set_q
    @q = Item.count_and_average_reviews.all.ransack(params[:q])
  end
end

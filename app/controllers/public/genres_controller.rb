class Public::GenresController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @genre = Genre.find(params[:id])

    #itemテーブルにreviewテーブルを結合
    @items = Item.all.left_joins(:reviews).group(:id).select('items.*, count(reviews.item_id) as count, avg(reviews.rate) as average').where(genre_id: @genre.id)
  end

  def search
    @items = @q.result
  end

  private

  #パラメータを元にデータを検索、@qに格納
  def set_q
    @q = Item.all.left_joins(:reviews).group(:id).select("items.*, count(reviews.item_id) as count, avg(reviews.rate) as average").ransack(params[:q])
  end

end

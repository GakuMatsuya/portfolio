class Public::GenresController < ApplicationController

  def index
    @genre = Genre.find(params[:id])
    
    #itemテーブルにreviewテーブルを結合
    @items = Item.all.left_joins(:reviews).group(:id).select('items.*, count(reviews.item_id) as count, avg(reviews.rate) as average').where(genre_id: @genre.id)
  end

end

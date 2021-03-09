class Public::GenresController < ApplicationController

  def index
    @genre = Genre.find(params[:id])
    @items = Item.where("genre_id = #{@genre.id}")
  end

end

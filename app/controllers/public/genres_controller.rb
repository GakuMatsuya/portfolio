class Public::GenresController < ApplicationController

  def index
    @genre = Genre.find(params[:id])
    @items = Item.where("genre_id = #{@genre.id}")
    
    @items.each do |item|
     #レビューがあれば平均を、なければ0を
      if item.reviews.blank?
        @average_review = 0
      else
        @average_review = item.reviews.average(:rate).round(1)
      end
    end
  end

end

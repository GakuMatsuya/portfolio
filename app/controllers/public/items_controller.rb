class Public::ItemsController < Public::ApplicationController

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews

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

end

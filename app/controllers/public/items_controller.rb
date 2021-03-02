class Public::ItemsController < Public::ApplicationController
  

  def index
  end

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews

    #レビューがあれば平均を、なければ0を
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rate)
    end
  end

end

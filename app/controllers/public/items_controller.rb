class Public::ItemsController < ApplicationController

  def index
  end

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews
  end

end

class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(admin_item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def index
    @items = Item.all
  end
  
  def show
  end

  def edit
  end

  def update
  end
  
  private

  def admin_item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id)
  end

end

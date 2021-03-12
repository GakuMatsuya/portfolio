class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(admin_item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(admin_item_params)
    redirect_to admin_item_path(@item)
  end
  
  private

  def admin_item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id)
  end

end

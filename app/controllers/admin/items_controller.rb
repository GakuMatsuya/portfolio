class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index, :search]
  layout "admin"

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(admin_item_params)
    if @item.save
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def index
    @items = Item.all.includes(:genre).page(params[:page]).per(10)
  end


  def search
    @items = @q.result
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(admin_item_params)
      flash[:notice] = "変更内容を保存しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def admin_item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id)
  end

  #パラメータを元にテーブルからデータを検索し、@qに代入
  def set_q
    @q = Item.all.left_joins(:reviews).group(:id).select("items.*, count(reviews.item_id) as count, avg(reviews.rate) as average").ransack(params[:q])
  end

end

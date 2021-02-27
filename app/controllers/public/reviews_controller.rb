class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @review = Review.new 
    @user = current_user
  end
  
  def create
  end

  def index
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def edit
  end
  
  def like
  end

  def update
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:rate, :text)
  end

end

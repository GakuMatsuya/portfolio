class Public::ReviewsController < ApplicationController
  
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

end

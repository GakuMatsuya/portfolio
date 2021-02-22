class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def edit 
  end

  def update
  end

  def index
  end

  def following 
  end

  def followers
  end

  def unsubscribe
  end

  def withdraw
  end

end

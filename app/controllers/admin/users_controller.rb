class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def edit
  end
  
  def update
  end
end

class Public::RelationshipsController < Public::ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = "フォローしました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "フォローに失敗しました"
      redirect_to user_path(@user)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = "フォローを解除しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "フォロー解除に失敗しました"
      redirect_to user_path(@user)
    end
  end

  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end

end

class Public::RelationshipsController < Public::ApplicationController
  def create
    @user = User.find(params[:user][:following_id])
    if current_user.follow(@user)
      flash[:notice] = "フォローしました"
    else
      flash[:alert] = "フォローに失敗しました"
    end
    # リロード後、メッセージが残らないようにする
    flash.discard
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.unfollow(@user)
      flash[:notice] = "フォローを解除しました"
    else
      flash[:alert] = "フォロー解除に失敗しました"
    end
    # リロード後、メッセージが残らないようにする
    flash.discard
  end
end

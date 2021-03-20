class Public::UsersController < Public::ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :timeline, :unsubscribe, :withdraw]

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: @user.id).includes(:item).page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更内容を保存しました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  def likes
    @user = User.find(params[:id])
    @reviews = @user.liked_reviews.includes(:item, :user).page(params[:page]).per(5)
  end

  def timeline
    @user = User.find(current_user.id)
    @follow_users = @user.following
    @reviews = Review.where(user_id: @follow_users).includes(:item, :user)
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(user_params)
    #ログアウトさせる
    reset_session
    redirect_to "/"
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
  end

  #他ユーザーの情報編集を制限
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:alert] = "アクセス権限がありません"
      redirect_to user_path(@user)
    end
  end

end
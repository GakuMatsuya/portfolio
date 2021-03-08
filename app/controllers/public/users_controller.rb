class Public::UsersController < Public::ApplicationController
  before_action :ensure_correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    #currnt_userと@userのリレーションシップを取得
    @relationship = current_user.relationships.find_by(follow_id: @user.id)
    @set_relationship = current_user.relationships.new
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

  def index
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  def likes
    @user = User.find(params[:id])
  end

  def timeline
    @user = User.find(current_user.id)
    @follow_users = @user.followings.all
    @reviews = Review.where(user_id: @follow_users)
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
     redirect_to user_path(@user)
    end
  end

end

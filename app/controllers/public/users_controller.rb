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
    @user.update(user_params)
    redirect_to user_path(@user)
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

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  #他ユーザーの情報編集を制限
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
     redirect_to user_path(@user)
    end
  end

end

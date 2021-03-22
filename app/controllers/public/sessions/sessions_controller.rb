# frozen_string_literal: true

class Public::Sessions::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  #ログイン後、マイページに遷移
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  #ログアウト後、トップページへ
  def after_sign_out_path_for(resource)
    "/"
  end

  protected

   #退会済みユーザのログインを阻止
  def reject_inactive_user
    @user = User.find(email: params[:user][:email])
  
    #パスワードが正しいかチェックし、メソッドがfalseであることを確認。両方に当てはまればログインを拒否
    if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
      redirect_to new_user_session_path
    end
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

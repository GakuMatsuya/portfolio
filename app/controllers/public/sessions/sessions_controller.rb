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
    user_path(resource.id)
  end
  
  #ログアウト後、ログインページへ
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

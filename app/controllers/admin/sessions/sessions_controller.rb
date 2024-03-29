# frozen_string_literal: true

class Admin::Sessions::SessionsController < Devise::SessionsController
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

  # ログイン後、管理者側の商品一覧ページへ
  def after_sign_in_path_for(resource)
    admin_items_path
  end

  # ログアウト後、管理者ログインページへ
  def after_sign_out_path_for(resource)
    admin_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

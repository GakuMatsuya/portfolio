class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])           #管理者、ユーザーのログイン時
    devise_parameter_sanitizer.permit(:sign_in, keys: [:password])        #管理者、ユーザーのログイン時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])            #ユーザー登録時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])           #ユーザー登録時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:password])        #ユーザー登録時
  end

end

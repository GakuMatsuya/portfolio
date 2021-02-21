Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, controllers: {
    sessions: "admin/sessions/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

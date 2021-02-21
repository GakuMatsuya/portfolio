Rails.application.routes.draw do
  
  devise_for :users
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions/sessions"
  }
  
  namespace :admin do
    resources :items, except:[:destroy]
    resources :users, except:[:new, :create, :destroy]
  end

end

Rails.application.routes.draw do
  
  devise_for :user, controllers: {
    sessions: "public/sessions/sessions"
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions/sessions"
  }
  
  namespace :admin do
    resources :items, except:[:destroy]
    resources :users, except:[:new, :create, :show, :destroy]
  end

end

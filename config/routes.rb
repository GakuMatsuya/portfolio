Rails.application.routes.draw do
  
  #urlを設定
  devise_for :users, path: '', controllers: {
    sessions: "public/sessions/sessions",
    registrations: "public/sessions/registrations"
  }
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions/sessions"
  }
  
  get "/" => "public/homes#top"
  post "like/:id" => "public/likes#create", as: "create_like"
  delete "like/:id" => "public/likes#destroy", as: "destroy_like"
  
  #urlにadminをつけることで、ユーザー側と区別
  namespace :admin do
    resources :items, except:[:destroy]
    resources :users, except:[:new, :create, :show, :destroy]
  end
  
  #ユーザー側のurlにはファイル階層の記述はしない
  scope module: :public do
    resources :users, except:[:create, :new, :destroy] do
      get :followings, on: :member
      get :followers, on: :member
      get :likes, on: :member
      get :timeline, on: :member
    end
    resources :items, only: [:index, :show] do
      resources :reviews, except:[:index] do
        resources :comments, only: [:create, :destroy] 
      end
    end
    resources :relationships, only: [:create, :destroy]
  end
end

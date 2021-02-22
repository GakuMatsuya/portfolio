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
  
  #urlにadminをつけることで、ユーザー側と区別
  namespace :admin do
    resources :items, except:[:destroy]
    resources :users, except:[:new, :create, :show, :destroy]
  end
  
  #ユーザー側のurlにはファイル階層の記述はしない
  scope module: :public do
    resources :users, except:[:create, :new, :destroy]
  end

end

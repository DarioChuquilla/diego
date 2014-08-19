Diego::Application.routes.draw do
  scope "(:locale)", :locale => /en|EC/ do
    # get "reports/index"

    # get "reports/received"

    # get "reports/done"

    root :to =>'home#index'
    
    get "home/index"

    devise_for :users, :controllers => { :registrations => 'registration' }#, :sessions => "sessions" }

    namespace :admin do
      resources :hotels do
        resources :promotions
        resources :hotel_photos, path: 'photos', as: 'photos'
      end
      resources :reports, only: [:index ] do
        collection do
          get :received
          get :done
        end
      end
    end
    
    resources :hotel, only:[:show] do
      collection do
        get :nearest
        get :price
        get :cities
        get :promo
      end
    end
    
  end
end

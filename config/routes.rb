Diego::Application.routes.draw do
  
  scope "(:locale)" do
    # get "reports/index"

    # get "reports/received"

    # get "reports/done"
    
    get "404", :to => "application#page_not_found", as: "not_found_page"

    root :to =>"home#index"
    
    get "home/index"

    devise_for :users, :controllers => { :registrations => "registration", :sessions => "sessions", :passwords => "password" }

    namespace :admin do
      resources :accounts, only: [:show, :edit, :update] do
        member do
          get :change_password
        end
      end
      resources :hotels do
        member  do
          get :toggle_active
        end
        resources :promotions
        resources :rooms do
          resources :room_photos, path: "photos", as: "photos"
        end
        resources :hotel_photos, path: "photos", as: "photos"
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
      member do
        get :room, path: "room/:room_id"
      end
    end

    get "get_hotels_nearby", to: "hotel#get_hotels_nearby", path: "hotel/get_hotels_nearby/:lng/:level", as: "get_hotels_nearby"
    
  end
end

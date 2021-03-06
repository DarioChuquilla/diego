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
      resources :images
      resources :hotels do
        member  do
          get :toggle_active
        end
        resources :promotions
        resources :rooms do
          resources :room_photos, path: "photos", as: "photos"
          resources :specialties do
            collection do
              get :get_specialties_list, path: "get_specialties_list", as: "get_specialties_list"
            end
          end
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
      resources :comments, only: [:index, :show, :new, :create]#, path: "room/:room_id/comments"
      resources :room, only:[:show] do
        resources :reservations, only: [:index,:edit ,:show, :new, :create]#, path: "room/:room_id/comments"
      end
    end

    

    get "get_hotels_nearby", to: "hotel#get_hotels_nearby", path: "/get_hotels_nearby", as: "get_hotels_nearby"
    get "get_hotels_by_city", to: "hotel#get_hotels_by_city", path: "/get_hotels_by_city/:city", as: "get_hotels_by_city"
    
  end
end

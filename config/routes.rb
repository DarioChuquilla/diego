Diego::Application.routes.draw do

  get "hotel/index"

  

  

  root :to =>'home#index'
  
  get "home/index"

  devise_for :users, :controllers => { :registrations => 'registration' }#, :sessions => "sessions" }

  
  resources :hotel, only:[:show] do
    member do
      get :nearest
      get :price
      get :cities
      get :promo
    end
  end
end

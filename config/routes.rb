Diego::Application.routes.draw do

  root :to =>'home#index'
  
  get "home/index"

  devise_for :users, :controllers => { :registrations => 'registration' }#, :sessions => "sessions" }

  namespace :admin do
    resources :hotels do
      resources :promotions
      resources :hotel_photos, path: 'photos', as: 'photos'
    end 
  end
  
  resources :hotel, only:[:show] do
    member do
      get :nearest
      get :price
      get :cities
      get :promo
    end
  end
end

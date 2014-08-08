Diego::Application.routes.draw do

  root :to =>'home#index'
  
  get "home/index"

  devise_for :users, :controllers => { :registrations => 'registration', :sessions => "sessions" }

  namespace :admin do
    resources :hotels
  end

end

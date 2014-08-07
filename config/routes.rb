Diego::Application.routes.draw do
  
  root :to => 'hotels#index'

  get "hotels/index"

  devise_for :users, :controllers => { :sessions => "sessions", :registrations => 'registration' }

  namespace :admin do
    resources :hotels
  end
end

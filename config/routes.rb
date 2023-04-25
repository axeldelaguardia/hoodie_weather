Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

	namespace :api do
		namespace :v0 do
			resources :forecast, only: :index
			resources :users, only: :create
			post "/sessions", to: "sessions#login"
			post :road_trip, to: "road_trip#index"
			resources :salaries, only: :index
		end
	end
end

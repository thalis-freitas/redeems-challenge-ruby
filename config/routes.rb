Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
      resources :redeems, only: %i[create]
      resources :redeem_pages, only: %i[show]
  	end
  end
end

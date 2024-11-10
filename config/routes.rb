Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
  	namespace :v1 do
      resources :redeems, only: %i[create]
      resources :redeem_pages, only: %i[show]
  	end
  end
end

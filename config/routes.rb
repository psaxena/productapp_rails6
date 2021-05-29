Rails.application.routes.draw do
  get "products/most_viewed", to: "products#get_most_viewed"

  resources :products

  root "products#index"
end

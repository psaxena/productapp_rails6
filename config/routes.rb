Rails.application.routes.draw do
  get "products/most_viewed", to: "products#get_most_viewed"

  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

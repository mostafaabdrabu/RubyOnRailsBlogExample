Rails.application.routes.draw do
  root "articles#index"
  
  get "/sub", to: "subscription#index"
  get "/sub/add", to: "subscription#index"
  post "/sub/add", to: "subscription#addSubscriptionContract"
  get "/sub/verify", to: "subscription#index"
  post "/sub/verify", to: "subscription#verifySubscription"
  resources :articles do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

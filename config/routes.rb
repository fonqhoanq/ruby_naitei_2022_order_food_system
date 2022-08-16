Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create show)
    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
    end
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope :api do
    resources :books, except: :put do
      get :download, to: "download#show"
    end

    resources :authors, except: :put
    resources :publishers, except: :put
    resources :users, except: :put

    resources :user_confirmations, only: :show, param: :confirmation_token
    resources :password_resets, only: [ :show, :create, :update ],
                                param: :reset_token

    resources :access_tokens, only: :create do
      delete "/", action: :destroy, on: :collection
    end

    resources :purchases, only: [ :index, :show, :create ]

    get "/search/:text", to: "search#index"
  end

  root to: "books#index"

  # Defines the root path route ("/")
  # root "posts#index"
end

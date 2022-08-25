Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    resources :subjects, only: %i(index)
    resources :users
    resources :exams, only: %i(show create update)

    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :relationships, only: %i(create)

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages, only: %i(index)
      resources :users, only: %i(index)
      resources :users do
        resources :exams, only: %i(index show)
      end
      resources :profile, only: %i(edit update)
      resources :account_activations, only: %i(update)
      resources :subjects, only: %i(index new create edit update destroy)
      resources  :subjects do 
        resources :questions
      end
      resources :questions
      resources :answers
    end
  end

end

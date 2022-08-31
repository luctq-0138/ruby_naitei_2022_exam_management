Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    resources :subjects, only: %i(index)
    devise_for :users, :controllers => {:registrations => "registrations"}
    resources :exams, only: %i(show create update)
    resources :users
    
    resources :relationships, only: %i(create)
    
    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages, only: %i(index)
      resources :users, only: %i(index)
      resources :users do
        resources :exams, only: %i(index show)
      end
      resources :account_activations, only: %i(update)
      resources :subjects, only: %i(index new create edit update destroy)
      resources  :subjects do
        resources :questions
      end
      resources :questions do
        collection {post :import}
      end
      resources :answers
    end
  end

end

Rails.application.routes.draw do
  scope "(:locale)", locale: /ja|en/ do
    root 'spots#index'

    resources :spots do
      collection do
        match 'search' => 'spots#search', via: [:get, :post], as: :search
      end
    end
    
    get '/signup', to: 'users#new'

    resources :users

    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :spot_reviews
    get '/spot_reviews/new', to: 'spot_reviews#new'
  end
end

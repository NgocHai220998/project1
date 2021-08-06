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
  end
end

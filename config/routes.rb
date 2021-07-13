Rails.application.routes.draw do
  root 'spots#index'
  resources :spots do
    collection do
      match 'search' => 'spots#search', via: [:get, :post], as: :search
    end
  end
end

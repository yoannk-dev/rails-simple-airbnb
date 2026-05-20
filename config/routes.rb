Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :flats do
    collection do
      get :search
    end
  end
end

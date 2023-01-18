Rails.application.routes.draw do
  resources :orders, only: %i[create update destroy]
end

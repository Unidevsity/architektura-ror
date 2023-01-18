Rails.application.routes.draw do
  resources :orders, only: %i[show create update destroy] do
    resources :order_lines, only: %i[create update destroy], controller: 'orders/order_lines'
    member do
      get :total
    end
  end
end

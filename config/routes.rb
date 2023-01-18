Rails.application.routes.draw do
  resources :orders, only: %i[create update destroy] do
    resources :order_lines, only: %i[create update destroy], controller: 'orders/order_lines'
  end
end

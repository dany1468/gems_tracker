Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tracking_gems

  resources :unread_gems

  resources :ignoring_gems
end

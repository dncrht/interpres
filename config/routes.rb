Rails.application.routes.draw do
  resources :texts

  resources :apps do
    get 'set', on: :member
  end

  resources :languages

  root 'texts#index'
end

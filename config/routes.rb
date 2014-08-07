Rails.application.routes.draw do
  resources :texts

  resources :apps do
    get 'set', on: :member
    get 'download/:iso', action: 'download', on: :member, as: 'download'
    patch 'token', action: 'create_token', on: :member, as: 'token'
  end

  resources :languages

  root 'texts#index'
end

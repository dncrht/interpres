Rails.application.routes.draw do
  resources :texts

  resources :apps do
    get 'set', on: :member
    get 'download/:iso', action: 'download', on: :member, as: 'download'
    patch 'token', action: 'create_token', on: :member, as: 'token'
    get 'enabled_languages', on: :collection
  end

  resources :languages

  root 'texts#index'
end

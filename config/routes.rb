Rails.application.routes.draw do
  resources :secret_spaces
  mount API => '/'

  devise_for :users

  mount GrapeSwaggerRails::Engine => '/doc'
end

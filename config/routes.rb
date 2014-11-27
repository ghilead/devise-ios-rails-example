Rails.application.routes.draw do
  devise_for :users
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/doc'
end

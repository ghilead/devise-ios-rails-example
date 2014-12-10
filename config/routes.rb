Rails.application.routes.draw do
  mount API => '/'

  devise_for :users
  resources :secret_spaces

  mount GrapeSwaggerRails::Engine => '/doc'

  if defined?(LetterOpenerWeb)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

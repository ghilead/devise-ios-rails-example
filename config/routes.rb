Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_ios_rails_for :users
  resources :secret_spaces

  devise_scope :user do
    post 'users/auth/facebook', to: 'devise_ios_rails/oauth#facebook'
    post 'users/auth/google',   to: 'devise_ios_rails/oauth#google'
  end

  if defined?(LetterOpenerWeb)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

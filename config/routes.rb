Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_ios_rails_for :users
  resources :secret_spaces

  if defined?(LetterOpenerWeb)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

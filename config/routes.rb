Rails.application.routes.draw do
  scope :v1 do
    devise_for :users
    resources :secret_spaces
  end

  mount GrapeSwaggerRails::Engine => '/doc'

  if defined?(LetterOpenerWeb)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

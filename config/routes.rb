Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/doc'
end

require 'grape-swagger'

module V1
  class Base < Grape::API
    version 'v1', using: :path

    include V1::ErrorHandler

    mount V1::Login

    add_swagger_documentation(api_version: 'v1')
  end
end

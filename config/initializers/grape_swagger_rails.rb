GrapeSwaggerRails.options.url = '/swagger_doc.json'
GrapeSwaggerRails.options.app_name = 'Saaskit'
GrapeSwaggerRails.options.app_url = ENV.fetch('DOMAIN_URL')

GrapeSwaggerRails.options.before_filter do |request|
  authenticated = UserService::AuthenticateAdmin
    .new(request.session[:user_id], request.session[:token]).call
  unless authenticated && !Rails.env.production?
    redirect_to '/admin/sign_in'
  end
end

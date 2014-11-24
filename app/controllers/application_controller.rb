class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def current_user
    @current_user = nil
  end
end

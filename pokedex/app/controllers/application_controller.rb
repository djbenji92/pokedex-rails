class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = exception.message
  if request.env['HTTP_REFERER'].present?
    redirect_to :back
  else
    redirect_to root_url
  end
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  private

  #redirection sign out
  def after_sign_out_path_for(resource_or_scope)
  	pokemons_path
  end
end

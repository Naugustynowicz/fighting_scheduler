class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # # -- devise & pundit part --
  # include Pundit::Authorization
  #
  # # before_action :authenticate_user!
  #
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  #
  # def index
  #   # just do nothing
  # end
  #
  # private # protected
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [ :email ])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [ :email ])
  # end
end

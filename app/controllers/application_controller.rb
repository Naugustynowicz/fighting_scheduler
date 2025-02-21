class ApplicationController < ActionController::Base
  include ActionController::Cookies
  # after_action :set_csrf_cookie
  # def fallback_index_html
  #   render file: "public/index.html"
  # end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  # before_action :authenticate_user!

  protect_from_forgery with: :exception # , prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    # just do nothing
  end

  private # protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email ])
  end

  # def set_csrf_cookie
  #   cookies["CSRF-TOKEN"] = {
  #     value: form_authenticity_token,
  #     secure: true,
  #     same_site: :strict
  #     # domain: "localhost:3000/ui/"
  #   }
  # end
end

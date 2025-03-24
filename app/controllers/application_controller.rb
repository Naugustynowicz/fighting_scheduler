class ApplicationController < ActionController::Base
  include ActionController::Cookies
  # after_action :set_csrf_cookie
  # after_action :set_csrf_token
  # def fallback_index_html
  #   render file: "public/index.html"
  # end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  # before_action :authenticate_user!

  # protect_from_forgery with: :exception # , prepend: true
  # before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token, raise: false
  # skip_before_action :verify_authenticity_token, only: :create

  def index
    # just do nothing
  end

  private # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [ :email ])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [ :email ])
  # end

  # WIP
  # def set_csrf_cookie
  #   cookies["CSRF-TOKEN"] = {
  #     value: form_authenticity_token,
  #     secure: true,
  #     same_site: :strict
  #     # domain: "localhost:3000/ui/"
  #   }
  # end

  # def set_csrf_token
  #   cookies["XSRF-TOKEN"] = form_authenticity_token if protect_against_forgery?
  # end
  #
  # def verified_request?
  #   super || valid_authenticity_token?(session, request.headers["X-XSRF-TOKEN"])
  # end
end

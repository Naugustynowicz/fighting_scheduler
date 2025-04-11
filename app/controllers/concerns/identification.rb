module Identification
  extend ActiveSupport::Concern

  private

  def current_user
    if request.headers["Authorization"].present?
      jwt_payload = JWT.decode(
        request.headers["Authorization"].split(" ").last,
        Rails.application.credentials.devise_jwt_secret_key!
      ).first
      return User.find(jwt_payload["sub"])
    end

    super
  end
end

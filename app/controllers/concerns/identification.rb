module Identification
  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]
  end
end

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FightingScheduler
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    # config.secrets = config_for(:secrets)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     # origins "http://localhost:5173", "http://localhost:3000"
    #     origins "*"
    #
    #     resource "*",
    #       headers: :any,
    #       methods: [ :get, :post, :put, :patch, :delete, :options, :head ]
    #     # credentials: true
    #     # absoultly remember to set this in to true, and in your ajax to set  credentials: 'include'
    #   end
    #
    #   # allow do
    #   #   origins "http://localhost:5000" # 5000 is the port your can set yours to what ever you want.
    #   #
    #   #   resource "*",
    #   #     headers: :any,
    #   #     methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
    #   #     credentials: true
    #   # end
    # end
  end
end

# README

# start dev app
bin/vite dev # with frontend
rails server # backend only

# generate secret key
bundle exec rails secret
# with VSCode, open the encrypted credentials file
EDITOR='code --wait' rails credentials:edit

# Default text
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

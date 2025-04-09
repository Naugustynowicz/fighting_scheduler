# README

# installation instructions
This API is the backend part of my finghting scheduler project. You can use it as a json api or with this associated frontend. You can install or run this app localy or with docker.

# local installation on linux ubuntu (Need Ubuntu Jammy 22.04 or newer)
Install sqlite3 (present by default on every ubuntu distribution) :
  $ sudo apt-get install sqlite3

Install ruby :
  # Install dependencies with apt
  $ sudo apt update
  $ sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev

  # Install Mise version manager
  $ curl https://mise.run | sh
  $ echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.bashrc
  $ source ~/.bashrc

  # Install Ruby globally with Mise
  $ mise use -g ruby@3

Get all dependencies:
  $ bundle install

launch API:
  $ rails s

# docker instructions
build containers & launch API:
  $ docker compose up --build -V
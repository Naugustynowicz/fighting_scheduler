class SportsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  skip_before_action :verify_authenticity_token

  private

  def database
    Sport
  end

  def request_params
    params.expect(sport: [ :name, :description, :status ])
  end
end

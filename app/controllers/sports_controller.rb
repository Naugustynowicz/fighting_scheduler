class SportsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Sport
  end

  def request_params
    params.expect(sport: [ :name, :description ])
  end
end

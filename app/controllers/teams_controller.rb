class TeamsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Team
  end

  def request_params
    params.require(:team).permit(:name, :description, :status)
  end
end

class SportsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Sport
  end

  def request_params
    params.require(:sport).permit(
      :name, :description, :status
    )
  end
end

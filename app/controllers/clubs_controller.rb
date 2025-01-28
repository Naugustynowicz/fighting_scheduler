class ClubsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Club
  end

  def request_params
    params.require(:club).permit(
      :name, :description, :status_id, :user_id, :sport_id, :location_id
    )
  end
end

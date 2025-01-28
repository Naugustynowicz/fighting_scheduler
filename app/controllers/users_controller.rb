class UsersController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    User
  end

  def request_params
    params.require(:user).permit(
      :name, :password, :other, :position, :first_team, :club_id, :team_id, :location_id
    )
  end
end

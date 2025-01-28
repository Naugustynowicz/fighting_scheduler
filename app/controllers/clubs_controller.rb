class ClubsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Club
  end

  def request_params
    params.require(:club).permit(:name, :description, :status)
  end
end

class LocationsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Location
  end

  def request_params
    params.require(:location).permit(
      :name, :other, :street, :city, :postal_code, :country, :status
    )
  end
end

class CircuitsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Circuit
  end

  def request_params
    params.require(:circuit).permit(
      :name, :description, :user_id, :status_id
    )
  end
end

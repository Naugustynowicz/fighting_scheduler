class RolesController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Role
  end

  def request_params
    params.require(:role).permit(:name, :description, :status)
  end
end

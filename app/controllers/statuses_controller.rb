class StatusesController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Status
  end

  def request_params
    params.require(:status).permit(:name)
  end
end

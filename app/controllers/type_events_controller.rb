class TypeEventsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    TypeEvent
  end

  def request_params
    params.require(:type_event).permit(:name, :description, :status)
  end
end

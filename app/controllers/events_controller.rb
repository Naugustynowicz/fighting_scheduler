class EventsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    Event
  end

  def request_params
    params.require(:event).permit(:name, :description, :status)
  end
end

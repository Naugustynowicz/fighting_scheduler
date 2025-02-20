class EventsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  def subscribe
    @event = database.find(params[:id])
    @event.subscribe(current_user)

    render json: @event.users
  end

  def attendees
    @event = database.find(params[:id])

    render json: @event.users
  end

  private

  def database
    Event
  end

  def request_params
    params.expect(event: [
      :start_date, :end_date, :attendees_nb, :venue_fee, :required_score, :name, :description, :rules, :schedule, :brackets, :user_id, :status_id, :location_id, :sport_id, :type_event_id
    ])
  end
end

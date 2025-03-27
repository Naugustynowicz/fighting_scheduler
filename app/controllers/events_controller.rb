class EventsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  # TODO use patch request instead
  def subscribe
    event = database.find(params[:id])
    authorize event

    event.subscribe(current_user)
    render json: event.users
  end

  def attendees
    event = database.find(params[:id])
    authorize event

    render json: event.users
  end

  # TODO use post request instead
  def generate_tree_bracket
    event = database.find(params[:id])
    authorize event

    render json: render_bracket(event.generate_tree_bracket)
  end

  def display_tree_bracket
    event = database.find(params[:id])
    authorize event

    render json: render_bracket(event.bracket)
  end

  private

  def render_bracket(match)
    return { match:, user1: match.user1, user2: match.user2 } if match.previous_match_1.blank? && match.previous_match_2.blank?

    {
      match:, user1: match.user1, user2: match.user2,
      submatch1: render_bracket(Match.find(match.previous_match_1)),
      submatch2: render_bracket(Match.find(match.previous_match_2))
    }
  end

  def database
    Event
  end

  def request_params
    params.expect(event: [
      :start_date, :end_date, :attendees_nb, :venue_fee, :required_score, :name, :description, :rules, :schedule, :bracket, :user_id, :status_id, :location_id, :sport_id, :type_event_id
    ])
  end
end

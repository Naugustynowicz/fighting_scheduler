class EventsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  def determine_winner
    match = database.find(params[:id])
    match.determine_winner(params[:winning_user])
  end

  def update_match
    match = database.find(params[:id])
    match.update_match
  end

  private

  def database
    Match
  end

  def request_params
    params.expect(match: [
      :event, :user1, :user2, :winnier, :previous_match_1, :previous_match_2
    ])
  end
end

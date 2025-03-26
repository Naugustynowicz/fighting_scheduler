class MatchesController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  # TODO add some response here (render :json)
  def determine_winner
    match = database.find(params[:id])
    winner = User.find(params[:match][:winner])
    match.determine_winner(winner)
  end

  # TODO use patch request instead
  # TODO add some response here (render :json)
  def update_match
    match = database.find(params[:id])
    match.update_match
  end

  def show
    data = database.find(params[:id])
    authorize data

    match_infos = { match: data, user1: data.user1, user2: data.user2 }
    render json: match_infos
  end

  private

  def database
    Match
  end

  def request_params
    params.expect(match: [
      :event_id, :user_id, :user2_id, :winner, :previous_match_1, :previous_match_2
    ])
  end
end

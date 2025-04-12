class ClubsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  def add_training
    data = database.find(params[:id])
    authorize data

    training = Event.find(request_params[:event_id])
    # raise StandardError.new("this event is not a training") unless TypeEvent.find(training.type_event_id).name.eql? "training"
    data.add_training training
    render json: training
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  def remove_training
    data = database.find(params[:id])
    authorize data

    training = Event.find(request_params[:event_id])
    # raise StandardError.new("this event is not a training") unless TypeEvent.find(training.type_event_id).name.eql? "training"
    data.remove_training training
    render json: training
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  def list_events
    data = database.find(params[:id])
    authorize data

    list_events = Event.where(club_id: data.id)
    render json: list_events
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  private

  def database
    Club
  end

  def request_params
    params.require(:club).permit(
      :name, :description, :status_id, :user_id, :sport_id, :location_id, :event_id
    )
  end
end

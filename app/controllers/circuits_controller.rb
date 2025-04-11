class CircuitsController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  def add_event
    data = database.find(params[:id])
    authorize data

    data.add_event(
      Event.find(request_params[:event_id])
    )
    render json: data
  rescue StandardError => e
    render json: e
  end

  def remove_event
    data = database.find(params[:id])
    authorize data

    data.remove_event(
      Event.find(request_params[:event_id])
    )
    render json: data
  rescue StandardError => e
    render json: e
  end

  private

  def database
    Circuit
  end

  def request_params
    params.require(:circuit).permit(
      :name, :description, :user_id, :status_id, :event_id
    )
  end
end

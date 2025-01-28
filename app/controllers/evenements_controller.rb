class EvenementsController < ApplicationController
  include Identification

  def index
    @evenements = Evenement.all
  end

  def show
    @evenement = Evenement.find(params[:id])
  end

  def new
    @evenement = Evenement.new
  end

  def create
    @evenement = Evenement.new(evenement_params)

    if @evenement.save
      if Sport.find_by(id: evenement_params[:sports_id]).nil?
        redirect_to @sport.new
      end
      if Location.find_by(id: evenement_params[:locations_id]).nil?
        redirect_to @location.new
      end
      redirect_to @evenement
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @evenement = Evenement.find(params[:id])
  end

  def update
    @evenement = Evenement.find(params[:id])

    if @evenement.update(evenement_params)
      redirect_to @evenement
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @evenement = Evenement.find(params[:id])
    @evenement.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def evenement_params
    params.require(:evenement).permit(:type_event, :sports_id, :locations_id, :start_date, :end_date, :attendees_nb, :venue_fee, :name, :description, :rules, :schedule, :brackets, :status)
  end
end

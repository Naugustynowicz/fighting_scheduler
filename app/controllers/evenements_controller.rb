class EvenementsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]

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
    params.require(:evenement).permit(:type_event, :start_date, :end_date, :attendees_nb, :venue_fee, :name, :description, :rules, :schedule, :brackets, :status)
  end
end

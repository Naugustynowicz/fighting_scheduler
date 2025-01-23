class SportsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]

  def index
    @sports = Sport.all
  end

  def show
    @sport = Sport.find(params[:id])
  end

  def new
    @sport = Sport.new
  end

  def create
    @sport = Sport.new(sport_params)

    if @sport.save
      redirect_to @sport
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @sport = Sport.find(params[:id])
  end

  def update
    @sport = Sport.find(params[:id])

    if @sport.update(sport_params)
      redirect_to @sport
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sport = Sport.find(params[:id])
    @sport.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def sport_params
    params.require(:sport).permit(:name, :description, :status)
  end
end

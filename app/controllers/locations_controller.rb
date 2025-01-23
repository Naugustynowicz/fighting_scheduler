class LocationsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update(location_params)
      redirect_to @location
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def location_params
    params.require(:location).permit(:name, :other, :street, :city, :postal_code, :country, :status)
  end
end

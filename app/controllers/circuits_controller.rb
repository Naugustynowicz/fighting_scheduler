class CircuitsController < ApplicationController
  include Identification

  def index
    @circuits = Circuit.all
  end

  def show
    @circuit = Circuit.find(params[:id])
  end

  def new
    @circuit = Circuit.new
  end

  def create
    @circuit = Circuit.new(circuit_params)

    if @circuit.save
      redirect_to @circuit
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @circuit = Circuit.find(params[:id])
  end

  def update
    @circuit = Circuit.find(params[:id])

    if @circuit.update(circuit_params)
      redirect_to @circuit
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @circuit = Circuit.find(params[:id])
    @circuit.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def circuit_params
    params.require(:circuit).permit(:name, :description, :status)
  end
end

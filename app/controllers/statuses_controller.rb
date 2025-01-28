class StatusesController < ApplicationController
  include Identification

  def index
    @statuses = Status.all
  end

  def show
    @status = Status.find(params[:id])
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)

    if @status.save
      redirect_to @status
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])

    if @status.update(status_params)
      redirect_to @status
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def status_params
    params.require(:status).permit(:name, :description, :status)
  end
end

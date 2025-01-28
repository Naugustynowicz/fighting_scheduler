class TypeEventsController < ApplicationController
  include Identification

  def index
    @type_events = TypeEvent.all
  end

  def show
    @type_event = TypeEvent.find(params[:id])
  end

  def new
    @type_event = TypeEvent.new
  end

  def create
    @type_event = TypeEvent.new(type_event_params)

    if @type_event.save
      redirect_to @type_event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @type_event = TypeEvent.find(params[:id])
  end

  def update
    @type_event = TypeEvent.find(params[:id])

    if @type_event.update(type_event_params)
      redirect_to @type_event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @type_event = TypeEvent.find(params[:id])
    @type_event.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def type_event_params
    params.require(:type_event).permit(:name, :description, :status)
  end
end

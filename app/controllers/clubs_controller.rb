class ClubsController < ApplicationController
  include Identification

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)

    if @club.save
      redirect_to @club
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @club = Club.find(params[:id])
  end

  def update
    @club = Club.find(params[:id])

    if @club.update(club_params)
      redirect_to @club
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @club = Club.find(params[:id])
    @club.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def club_params
    params.require(:club).permit(:name, :description, :status)
  end
end

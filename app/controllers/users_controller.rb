class UsersController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  # # -- devise & pundit part --
  # before_action :authenticate_user!
  # after_action :verify_authorized

  def index
    @users = User.all
    # authorize User
  end

  def show
    @user = User.find(params[:id])
    # authorize @user
  end

  def update
    @user = User.find(params[:id])
    # authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    # authorize user
    user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  private

  def database
    User
  end

  def request_params
    params.require(:user).permit(
      :name, :password, :other, :position, :first_team, :club_id, :team_id, :location_id
    )
  end

  # # -- devise & pundit part --
  # def secure_params
  #   params.require(:user).permit(:role)
  # end
end

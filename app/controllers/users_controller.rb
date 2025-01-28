class UsersController < ApplicationController
  include Identification
  include BasicDatabaseFunctions

  private

  def database
    User
  end

  def request_params
    params.require(:user).permit(:name, :description, :status)
  end
end

class ClubPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :club

  def initialize(user, club)
    @user = user # current_user
    @club = club
  end

  # def update?
  #   true
  # end
end

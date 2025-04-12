class ClubPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :club

  def initialize(user, club)
    @user = user # current_user
    @club = club
  end

  def add_training?
    update?
  end

  def remove_training?
    update?
  end

  def list_events?
    show?
  end
end

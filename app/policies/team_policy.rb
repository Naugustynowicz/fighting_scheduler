class TeamPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :team

  def initialize(user, team)
    @user = user # current_user
    @team = team
  end

  def update?
    true
  end
end

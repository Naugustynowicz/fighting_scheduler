class MatchPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :event

  def initialize(user, event)
    @user = user # current_user
    @event = event
  end

  # def show?
  #   true
  # end

  # def subscribe?
  #   show?
  # end

  # def update?
  #   true
  # end
end

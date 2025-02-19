class EventPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :event

  def initialize(user, event)
    @user = user # current_user
    @event = event
  end

  def update?
    true
  end
end

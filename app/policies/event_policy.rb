class EventPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :event

  def initialize(user, event)
    @user = user # current_user
    @event = event
  end

  def show?
    true
  end

  def subscribe?
    show?
  end

  def attendees?
    show?
  end

  def generate_tree_bracket?
    create?
  end

  def display_tree_bracket?
    show?
  end

  # def update?
  #   true
  # end
end

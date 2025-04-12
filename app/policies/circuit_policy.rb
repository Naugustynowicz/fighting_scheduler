class CircuitPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :circuit

  def initialize(user, circuit)
    @user = user # current_user
    @circuit = circuit
  end

  def show?
    true
  end

  def add_event?
    update?
  end

  def remove_event?
    update?
  end

  def list_events?
    show?
  end
end

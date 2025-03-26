class TypeEventPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :type_event

  def initialize(user, type_event)
    @user = user # current_user
    @type_event = type_event
  end

  # def update?
  #   true
  # end
end

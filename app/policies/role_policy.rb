class RolePolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :role

  def initialize(user, role)
    @user = user # current_user
    @role = role
  end

  def update?
    true
  end
end

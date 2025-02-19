class UserPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :requested_user

  def initialize(user, requested_user)
    @user = user # current_user
    @requested_user = requested_user
  end

  def update?
    true
  end
end

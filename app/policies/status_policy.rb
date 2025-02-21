class StatusPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :status

  def initialize(user, status)
    @user = user # current_user
    @status = status
  end

  # def update?
  #   true
  # end
end

class UserPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  # attr_reader :user, :requested_user

  # def initialize(user, requested_user)
  #   @user = user # current_user
  #   @requested_user = requested_user
  # end

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    # TODO
    # @current_user.admin?
    true
  end

  def show?
    @current_user.admin? or @current_user == @user
  end

  def create?
    true
  end

  def update?
    @current_user.admin? or @current_user == @user
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end

  # def update?
  #   true
  # end
end

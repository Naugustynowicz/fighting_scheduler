class SportPolicy < ApplicationPolicy
  include BasicDatabasePolicy

  attr_reader :user, :sport

  def initialize(user, sport)
    @user = user # current_user
    @sport = sport
  end

  # def update?
  #   true
  # end
end

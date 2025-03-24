class User < ApplicationRecord
  class UndefinedDefaultRole < StandardError; end
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_and_belongs_to_many :roles
  # enum role: [:user, :vip, :admin]

  has_many :events # as organizator
  has_and_belongs_to_many :events # as attendee

  after_initialize :set_default_role, if: :new_record?

  def admin?
    self&.roles&.any? { |role| role.name.eql? "admin" }
  end

  private

  def set_default_role
    default_role = Role.where name: "sportif"
    raise UndefinedDefaultRole unless default_role
    return if email.blank? && encrypted_password.blank?

    self.update_attribute(:roles, self.roles.push(default_role))
  end
end

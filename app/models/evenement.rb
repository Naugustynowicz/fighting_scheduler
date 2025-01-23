class Evenement < ApplicationRecord
  include Visible

  has_one :sports
  has_one :locations

  # has_many :comments, dependent: :destroy
  #
  validates :name, presence: true
  # validates :body, presence: true, length: { minimum: 10 }
end

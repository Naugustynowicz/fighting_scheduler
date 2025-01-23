class Location < ApplicationRecord
  include Visible

  validates :name, presence: true
end

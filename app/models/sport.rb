class Sport < ApplicationRecord
  include Visible

  validates :name, presence: true
end

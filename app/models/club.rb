class Club < ApplicationRecord
  def add_training(training)
    training.update! club_id: self.id
  end

  def remove_training(training)
    training.update! club_id: nil
  end
end

class Club < ApplicationRecord
  has_and_belongs_to_many :users

  def add_training(training)
    training.update! club_id: self.id
  end

  def remove_training(training)
    training.update! club_id: nil
  end

  def subscribe_user(user_id)
    new_trainee = User.find(user_id)
    users.push new_trainee
  end

  def delete_trainee(user_id)
    deleted_trainee = User.find user_id
    users.delete deleted_trainee
  end
end

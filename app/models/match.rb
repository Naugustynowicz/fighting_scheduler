class Match < ApplicationRecord
  # WIP (class)

  belongs_to :event
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"
  belongs_to :winner, class_name: "User", optional: true

  def determine_winner!(winning_user)
    update!(winner: winning_user)
  end
end

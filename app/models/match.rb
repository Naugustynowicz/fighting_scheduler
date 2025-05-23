class Match < ApplicationRecord
  belongs_to :event
  belongs_to :user1, class_name: "User", optional: true
  belongs_to :user2, class_name: "User", optional: true
  belongs_to :winner, class_name: "User", optional: true
  # belongs_to :previous_match_1, class_name: "Match", optional: true
  # belongs_to :previous_match_2, class_name: "Match", optional: true
  # belongs_to :next_match, class_name: "Match", optional: true

  # attr_reader :previous_match_1, :previous_match_2
  # attr_reader :user1, :user2

  def determine_winner(winning_user)
    return unless [ user1, user2 ].include? winning_user

    update!(winner: winning_user)
    Match.find(next_match).update_match if next_match.present?
  end

  def update_match
    update(user1: Match.find(previous_match_1)&.winner, user2: Match.find(previous_match_2)&.winner)
  end
end

class Event < ApplicationRecord
  # WIP (content)
  has_and_belongs_to_many :users
  has_many :matches

  def subscribe(user)
    self.users.push user
  end

  def generate_bracket(round)
    shuffled_users = users.shuffle

    shuffled_users.each_slice(2) do |user1, user2|
      Match.create!(event: self, user1:, user2:)
    end

    Match.where(event: self)
  end

  # def generate_bracket
  #   shuffled_users = users.shuffle
  #   round = 1
  #   matches = []
  #
  #   while shuffled_users.size > 1
  #     new_round_users = []
  #     shuffled_users.each_slice(2) do |user1, user2|
  #       match = Match.create!(event: self, user1:, user2:, round:)
  #       new_round_users << (match.winner || nil) # Placeholder logic for winner selection
  #     end
  #     shuffled_users = new_round_users
  #     round += 1
  #   end
  # end
end

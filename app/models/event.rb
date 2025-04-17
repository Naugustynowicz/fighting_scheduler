# require "tree"

class Event < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :matches
  belongs_to :bracket, class_name: "Match", optional: true

  attr_reader :current_round_matches

  def subscribe(user)
    return if users.include? user

    self.users.push user
  end

  def generate_tree_bracket
    first_round_match_list = generate_bracket
    final_match = Match.create!(event: self)
    @current_round_matches = []
    generate_tree(first_round_match_list, final_match)
    update! bracket: final_match
    final_match
  end

  private

  def generate_bracket
    shuffled_users = users.shuffle

    update! bracket: nil
    Match.where(event: self).each(&:destroy)
    first_round_match_list = []
    shuffled_users.each_slice(2) do |user1, user2|
      first_round_match_list.push(Match.create!(event: self, user1:, user2:))
    end

    first_round_match_list
  end

  def generate_tree(array, node)
    return if array.length < 2

    if array.length.eql? 2
      array.first.update! next_match: node.id
      array.second.update! next_match: node.id
      @current_round_matches.push array.first
      @current_round_matches.push array.second
      node.update! previous_match_1: array.first.id, previous_match_2: array.second.id
      return
    end

    previous_match_1 = Match.create(event: self, next_match: node.id)
    previous_match_2 = Match.create(event: self, next_match: node.id)
    node.update!(previous_match_1: previous_match_1.id, previous_match_2: previous_match_2.id)

    splitted_array = array.in_groups_of(array.length / 2, false)
    generate_tree(splitted_array.first, previous_match_1)
    generate_tree(splitted_array.last, previous_match_2)
  end
end

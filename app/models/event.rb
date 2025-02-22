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

  def generate_bracket
    shuffled_users = users.shuffle

    Match.where(event: self).each(&:destroy)
    first_round_match_list = []
    shuffled_users.each_slice(2) do |user1, user2|
      first_round_match_list.push(Match.create!(event: self, user1:, user2:))
    end

    first_round_match_list
  end

  def generate_tree_bracket
    first_round_match_list = generate_bracket
    final_match = Match.create!(event: self)
    @current_round_matches = []
    generate_tree(first_round_match_list, final_match)
    update! bracket: final_match
  end

  def generate_tree(array, node)
    debugger
    return if array.length < 2
    return unless array.length % 2 == 0

    if array.length.eql? 2
      # first_round_match_1 = Tree::TreeNode.new("name1", array.first)
      # first_round_match_2 = Tree::TreeNode.new("name2", array.last)
      @current_round_matches.push array.first
      @current_round_matches.push array.second
      node.update! previous_match_1: array.first, previous_match_2: array.second
      return
    end

    previous_match_1 = Match.create(event: self)
    previous_match_2 = Match.create(event: self)
    node.update!(previous_match_1:, previous_match_2:)

    splitted_array = array.in_groups_of(array.length / 2, false)
    generate_tree(splitted_array.first, previous_match_1)
    generate_tree(splitted_array.last, previous_match_2)
  end
end

require "tree"

class Event < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :matches

  attr_reader :current_round_matches

  def subscribe(user)
    return if users.include? user

    self.users.push user
  end

  def generate_bracket
    shuffled_users = users.shuffle

    Match.where(event: self).each(&:destroy)
    shuffled_users.each_slice(2) do |user1, user2|
      Match.create!(event: self, user1:, user2:)
    end

    Match.where(event: self)
  end

  def generate_tree_bracket
    first_round_match_list = generate_bracket
    root_node = Tree::TreeNode.new("ROOT", "Root Content")
    @current_round_matches = []
    generate_tree(first_round_match_list, root_node)
    root_node.to_json
  end

  def generate_tree(array, node)
    return if array.length < 2
    return unless array.length % 2 == 0

    if array.length.eql? 2
      first_round_match_1 = Tree::TreeNode.new("name1", array.first)
      first_round_match_2 = Tree::TreeNode.new("name2", array.last)
      @current_round_matches.push first_round_match_1
      @current_round_matches.push first_round_match_2
      node << first_round_match_1
      node << first_round_match_2
      return
    end

    node << Tree::TreeNode.new("name1", "content1")
    node << Tree::TreeNode.new("name2", "content2")

    splitted_array = array.in_groups_of(array.length / 2, false)
    generate_tree(splitted_array.first, node.children.first)
    generate_tree(splitted_array.last, node.children.last)
  end
end

require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "can subscribe to an event" do
    bob = users :bob
    event = events :simple_tournament

    event.subscribe(bob)

    assert_equal bob, event.users.last
  end

  test "can generate a bracket" do
    event = events :simple_tournament
    4.times do |i|
      attendee = User.create(name: "user#{i}", email: "user#{i}@email.com", password: "123456")
      event.subscribe(attendee)
    end

    event.generate_tree_bracket
    assert_nil event.bracket.user1
    assert_nil event.bracket.user2

    previous_match_1 = Match.find(event.bracket.previous_match_1)
    previous_match_2 = Match.find(event.bracket.previous_match_2)
    winner_match_1 = previous_match_1.user1
    winner_match_2 = previous_match_2.user2
    previous_match_1.determine_winner(winner_match_1)
    previous_match_2.determine_winner(winner_match_2)
    event.bracket.update_match

    assert_equal event.bracket.user1, winner_match_1
    assert_equal event.bracket.user2, winner_match_2
  end

  test "can generate a bigger bracket" do
    event = events :simple_tournament
    8.times do |i|
      attendee = User.create(name: "user#{i}", email: "user#{i}@email.com", password: "123456")
      event.subscribe(attendee)
    end
    event.generate_tree_bracket
    assert event.bracket
  end
end

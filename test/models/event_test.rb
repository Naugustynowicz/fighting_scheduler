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

    tournament_tree = event.generate_tree_bracket

    debugger
  end

  # remove_all!
end

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

    match_list = assert_difference "Match.count", 2 do
      event.generate_bracket(1)
    end
    assert_equal 2, match_list.length

    user1 = match_list.first.user1
    user2 = match_list.first.user2
    user3 = match_list.last.user1
    user4 = match_list.last.user2
    userlist = [ user1, user2, user3, user4 ].uniq

    assert_equal 4, userlist.length
  end
end

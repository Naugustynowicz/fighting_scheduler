require "test_helper"

class EventsControllerTest < ActionController::TestCase
  include Devise::Test::IntegrationHelpers
  test "can subscribe to an event" do
    user = users :bob
    event = events :simple_tournament

    sign_in user
    event.subscribe

    debugger
  end
end

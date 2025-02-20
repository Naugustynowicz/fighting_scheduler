require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "can subscribe to an event" do
    user = users :bob
    event = events :simple_tournament

    sign_in user
    get "/events/#{event.id}/subscribe"

    debugger
  end
end

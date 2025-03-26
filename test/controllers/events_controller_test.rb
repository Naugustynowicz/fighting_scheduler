require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see events list" do
    sign_in user

    get "/events"
    assert JSON.parse(response.body).include? JSON.parse(event.to_json)
  end

  test "everyone can see event details" do
    sign_in user

    get "/events/#{event.id}"
    assert_equal JSON.parse(response.body), JSON.parse(event.to_json)
  end

  test "standard user cannot create event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/events", params: payload
    end
    assert_equal "not allowed to EventPolicy#create? this Event", error.message
  end

  test "admin can create event" do
    sign_in admin

    post "/events", params: payload
    assert_response :created
    assert JSON.parse(Event.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/events/#{event.id}", params: payload
    end
    assert_equal "not allowed to EventPolicy#update? this Event", error.message
  end

  test "admin can modify event" do
    sign_in admin

    patch "/events/#{event.id}", params: payload
    assert_response :ok
    assert JSON.parse(Event.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/events/#{event.id}"
    end
    assert_equal "not allowed to EventPolicy#destroy? this Event", error.message
  end

  test "admin can delete event" do
    sign_in admin

    delete "/events/#{event.id}"
    assert_response :see_other
    refute JSON.parse(Event.all.to_json).include? JSON.parse(event.to_json)
  end

  # WIP test controllers owns functions
  test "can subscribe to an event" do
    sign_in user
    get "/events/#{event.id}/subscribe"
  end

  test "can see attendees list" do
    sign_in user
    get "/events/#{event.id}/attendees"
  end

  test "can see tree bracket" do
    sign_in user
    get "/events/#{event.id}/display_tree_bracket"
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def event
    @event ||= events :simple_tournament
  end

  def payload
    {
      event: {
        name: "event1",
        description: "whatdayawant"
      }
    }
  end
end

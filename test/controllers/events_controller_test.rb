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
      post "/events", params: {
        event: {
          name: "event1",
          description: "whatdayawant"
        }
      }
    end
    assert_equal "not allowed to EventPolicy#create? this Event", error.message
  end

  test "admin can create event" do
    sign_in admin

    post "/events", params: {
      event: {
        name: "event1",
        description: "whatdayawant"
      }
    }
    assert_response :created
    assert JSON.parse(Event.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/events/#{event.id}", params: {
        event: {
          name: "event1",
          description: "whatdayawant"
        }
      }
    end
    assert_equal "not allowed to EventPolicy#update? this Event", error.message
  end

  test "admin can modify event" do
    sign_in admin

    patch "/events/#{event.id}", params: {
      event: {
        name: "event1",
        description: "whatdayawant"
      }
    }
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
    assert event.users.include? user
  end

  test "can see attendees list" do
    sign_in user
    event.users.push users(:ann)
    event.users.push users(:jean)
    get "/events/#{event.id}/attendees"
    assert_equal event.users.to_json, response.body.itself
  end

  test "standard user cannot generate tree bracket" do
    sign_in user
    event.users.push user
    event.users.push users(:ann)
    event.users.push users(:jean)
    event.users.push users(:iris)

    error = assert_raises Pundit::NotAuthorizedError do
    get "/events/#{event.id}/generate_tree_bracket"
    end
    assert_equal "not allowed to EventPolicy#generate_tree_bracket? this Event", error.message
  end

  test "admin can generate tree bracket" do
    sign_in admin
    event.users.push user
    event.users.push users(:ann)
    event.users.push users(:jean)
    event.users.push users(:iris)

    get "/events/#{event.id}/generate_tree_bracket"
    event.reload
    assert event.bracket.present?
  end

  test "can see tree bracket" do
    sign_in user
    attendees_list = [ user, users(:ann), users(:jean), users(:iris) ]
    attendees_list.each { |att| event.users.push(att) }
    event.generate_tree_bracket

    get "/events/#{event.id}/display_tree_bracket"
    res_bracket = JSON.parse(response.body)
    assert_equal res_bracket["match"]["event_id"], event.id
    assert_equal res_bracket["submatch1"]["match"]["event_id"], event.id
    assert_equal res_bracket["submatch2"]["match"]["event_id"], event.id
    assert attendees_list.map(&:id).include? res_bracket["submatch1"]["user1"]["id"]
    assert attendees_list.map(&:id).include? res_bracket["submatch1"]["user2"]["id"]
    assert attendees_list.map(&:id).include? res_bracket["submatch2"]["user1"]["id"]
    assert attendees_list.map(&:id).include? res_bracket["submatch2"]["user2"]["id"]
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
end

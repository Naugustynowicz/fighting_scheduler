require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see type_events list" do
    sign_in user

    get "/type_events"
    assert JSON.parse(response.body).include? JSON.parse(type_event.to_json)
  end

  test "normal user can't see type_event details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/type_events/#{type_event.id}"
    end
    assert_equal "not allowed to TypeEventPolicy#show? this TypeEvent", error.message
  end

  test "admin can see type_event details" do
    sign_in admin

    get "/type_events/#{type_event.id}"
    assert_equal JSON.parse(response.body), JSON.parse(type_event.to_json)
  end

  test "standard user cannot create type_event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/type_events", params: { type_event: { name: "test1" } }
    end
    assert_equal "not allowed to TypeEventPolicy#create? this TypeEvent", error.message
  end

  test "admin can create type_event" do
    sign_in admin

    post "/type_events", params: { type_event: { name: "test1" } }
    assert_response :created
    assert JSON.parse(TypeEvent.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify type_event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/type_events/#{type_event.id}", params: { type_event: { name: "test1" } }
    end
    assert_equal "not allowed to TypeEventPolicy#update? this TypeEvent", error.message
  end

  test "admin can modify type_event" do
    sign_in admin

    patch "/type_events/#{type_event.id}", params: { type_event: { name: "test1" } }
    assert_response :ok
    assert JSON.parse(TypeEvent.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete type_event" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/type_events/#{type_event.id}"
    end
    assert_equal "not allowed to TypeEventPolicy#destroy? this TypeEvent", error.message
  end

  test "admin can delete type_event" do
    sign_in admin

    delete "/type_events/#{type_event.id}"
    assert_response :see_other
    refute JSON.parse(TypeEvent.all.to_json).include? JSON.parse(type_event.to_json)
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def type_event
    @type_event ||= type_events :tournament
  end
end

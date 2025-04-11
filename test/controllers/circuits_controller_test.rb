require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see circuits list" do
    sign_in user

    get "/circuits"
    assert JSON.parse(response.body).include? JSON.parse(circuit.to_json)
  end

  test "normal user can see circuit details" do
    sign_in user

    get "/circuits/#{circuit.id}"
    assert_equal JSON.parse(response.body), JSON.parse(circuit.to_json)
  end

  test "admin can see circuit details" do
    sign_in admin

    get "/circuits/#{circuit.id}"
    assert_equal JSON.parse(response.body), JSON.parse(circuit.to_json)
  end

  test "standard user cannot create circuit" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/circuits", params: { circuit: { name: "test1", description: "description1" } }
    end
    assert_equal "not allowed to CircuitPolicy#create? this Circuit", error.message
  end

  test "admin can create circuit" do
    sign_in admin

    post "/circuits", params: { circuit: { name: "test1", description: "description1" } }
    assert_response :created
    assert JSON.parse(Circuit.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify circuit" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/circuits/#{circuit.id}", params: { circuit: { name: "test1", description: "description1" } }
    end
    assert_equal "not allowed to CircuitPolicy#update? this Circuit", error.message
  end

  test "admin can modify circuit" do
    sign_in admin

    patch "/circuits/#{circuit.id}", params: { circuit: { name: "test1", description: "description1" } }
    assert_response :ok
    assert JSON.parse(Circuit.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete circuit" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/circuits/#{circuit.id}"
    end
    assert_equal "not allowed to CircuitPolicy#destroy? this Circuit", error.message
  end

  test "admin can delete circuit" do
    sign_in admin

    delete "/circuits/#{circuit.id}"
    assert_response :see_other
    refute JSON.parse(Circuit.all.to_json).include? JSON.parse(circuit.to_json)
  end

  test "admin can add and remove event to circuit" do
    sign_in admin
    assert_nil event.circuit_id

    patch "/circuits/#{circuit.id}/add_event", params: { circuit: { event_id: event.id } }
    assert_response :ok
    event.reload
    assert_equal event.circuit_id, circuit.id

    patch "/circuits/#{circuit.id}/remove_event", params: { circuit: { event_id: event.id } }
    assert_response :ok
    event.reload
    assert_nil event.circuit_id, circuit.id
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def circuit
    @circuit ||= circuits :simple_circuit
  end

  def event
    @event ||= events :simple_tournament
  end
end

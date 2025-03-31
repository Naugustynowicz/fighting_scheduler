require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see locations list" do
    sign_in user

    get "/locations"
    assert JSON.parse(response.body).include? JSON.parse(location.to_json)
  end

  test "normal user can't see location details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/locations/#{location.id}"
    end
    assert_equal "not allowed to LocationPolicy#show? this Location", error.message
  end

  test "admin can see location details" do
    sign_in admin

    get "/locations/#{location.id}"
    assert_equal JSON.parse(response.body), JSON.parse(location.to_json)
  end

  test "standard user cannot create location" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/locations", params: payload
    end
    assert_equal "not allowed to LocationPolicy#create? this Location", error.message
  end

  test "admin can create location" do
    sign_in admin

    post "/locations", params: payload
    assert_response :created
    assert JSON.parse(Location.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify location" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/locations/#{location.id}", params: payload
    end
    assert_equal "not allowed to LocationPolicy#update? this Location", error.message
  end

  test "admin can modify location" do
    sign_in admin

    patch "/locations/#{location.id}", params: payload
    assert_response :ok
    assert JSON.parse(Location.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete location" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/locations/#{location.id}"
    end
    assert_equal "not allowed to LocationPolicy#destroy? this Location", error.message
  end

  test "admin can delete location" do
    sign_in admin

    delete "/locations/#{location.id}"
    assert_response :see_other
    refute JSON.parse(Location.all.to_json).include? JSON.parse(location.to_json)
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def location
    @location ||= locations :location1
  end

  def payload
    @payload ||= {
      location: {
        name: "location1",
        other: "whatdayawant",
        street: "1 street",
        city: "city",
        postal_code: "12345",
        country: "country"
      }
    }
  end
end

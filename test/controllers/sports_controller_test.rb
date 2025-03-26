require "test_helper"

class SportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see sports list" do
    sign_in user

    get "/sports"
    assert JSON.parse(response.body).include? JSON.parse(sport.to_json)
  end

  test "normal user can't see sport details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/sports/#{sport.id}"
    end
    assert_equal "not allowed to SportPolicy#show? this Sport", error.message
  end

  test "admin can see sport details" do
    sign_in admin

    get "/sports/#{sport.id}"
    assert_equal JSON.parse(response.body), JSON.parse(sport.to_json)
  end

  test "standard user cannot create sport" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/sports", params: payload
    end
    assert_equal "not allowed to SportPolicy#create? this Sport", error.message
  end

  test "admin can create sport" do
    sign_in admin

    post "/sports", params: payload
    assert_response :created
    assert JSON.parse(Sport.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify sport" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/sports/#{sport.id}", params: payload
    end
    assert_equal "not allowed to SportPolicy#update? this Sport", error.message
  end

  test "admin can modify sport" do
    sign_in admin

    patch "/sports/#{sport.id}", params: payload
    assert_response :ok
    assert JSON.parse(Sport.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete sport" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/sports/#{sport.id}"
    end
    assert_equal "not allowed to SportPolicy#destroy? this Sport", error.message
  end

  test "admin can delete sport" do
    sign_in admin

    delete "/sports/#{sport.id}"
    assert_response :see_other
    refute JSON.parse(Sport.all.to_json).include? JSON.parse(sport.to_json)
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def sport
    @sport ||= sports :sport1
  end

  def payload
    {
      sport: {
        name: "test1",
        description: "whatdayawant"
      }
    }
  end
end

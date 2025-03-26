require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see teams list" do
    sign_in user

    get "/teams"
    assert JSON.parse(response.body).include? JSON.parse(team.to_json)
  end

  test "normal user can't see team details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/teams/#{team.id}"
    end
    assert_equal "not allowed to TeamPolicy#show? this Team", error.message
  end

  test "admin can see team details" do
    sign_in admin

    get "/teams/#{team.id}"
    assert_equal JSON.parse(response.body), JSON.parse(team.to_json)
  end

  test "standard user cannot create team" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/teams", params: { team: { name: "test1", description: "description1" } }
    end
    assert_equal "not allowed to TeamPolicy#create? this Team", error.message
  end

  test "admin can create team" do
    sign_in admin

    post "/teams", params: { team: { name: "test1", description: "description1" } }
    assert_response :created
    assert JSON.parse(Team.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify team" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/teams/#{team.id}", params: { team: { name: "test1", description: "description1" } }
    end
    assert_equal "not allowed to TeamPolicy#update? this Team", error.message
  end

  test "admin can modify team" do
    sign_in admin

    patch "/teams/#{team.id}", params: { team: { name: "test1", description: "description1" } }
    assert_response :ok
    assert JSON.parse(Team.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete team" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/teams/#{team.id}"
    end
    assert_equal "not allowed to TeamPolicy#destroy? this Team", error.message
  end

  test "admin can delete team" do
    sign_in admin

    delete "/teams/#{team.id}"
    assert_response :see_other
    refute JSON.parse(Team.all.to_json).include? JSON.parse(team.to_json)
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def team
    @team ||= teams :simple_team
  end
end

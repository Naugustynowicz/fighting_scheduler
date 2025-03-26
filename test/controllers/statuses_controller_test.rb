require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see statuses list" do
    sign_in user

    get "/statuses"
    assert JSON.parse(response.body).include? JSON.parse(status.to_json)
  end

  test "normal user can't see status details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/statuses/#{status.id}"
    end
    assert_equal "not allowed to StatusPolicy#show? this Status", error.message
  end

  test "admin can see status details" do
    sign_in admin

    get "/statuses/#{status.id}"
    assert_equal JSON.parse(response.body), JSON.parse(status.to_json)
  end

  test "standard user cannot create status" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/statuses", params: { status: { name: "test1" } }
    end
    assert_equal "not allowed to StatusPolicy#create? this Status", error.message
  end

  test "admin can create status" do
    sign_in admin

    post "/statuses", params: { status: { name: "test1" } }
    assert_response :created
    assert JSON.parse(Status.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify status" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/statuses/#{status.id}", params: { status: { name: "test1" } }
    end
    assert_equal "not allowed to StatusPolicy#update? this Status", error.message
  end

  test "admin can modify status" do
    sign_in admin

    patch "/statuses/#{status.id}", params: { status: { name: "test1" } }
    assert_response :ok
    assert JSON.parse(Status.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete status" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/statuses/#{status.id}"
    end
    assert_equal "not allowed to StatusPolicy#destroy? this Status", error.message
  end

  test "admin can delete status" do
    sign_in admin

    delete "/statuses/#{status.id}"
    assert_response :see_other
    refute JSON.parse(Status.all.to_json).include? JSON.parse(status.to_json)
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def status
    @status ||= statuses :open
  end
end

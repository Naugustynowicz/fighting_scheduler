require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see roles list" do
    sign_in user

    get "/roles"
    assert JSON.parse(response.body).include? JSON.parse(role.to_json)
  end

  test "normal user can't see role details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/roles/#{role.id}"
    end
    assert_equal "not allowed to RolePolicy#show? this Role", error.message
  end

  test "admin can see role details" do
    sign_in admin

    get "/roles/#{role.id}"
    assert_equal JSON.parse(response.body), JSON.parse(role.to_json)
  end

  test "standard user cannot create role" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/roles", params: { role: { name: "test1" } }
    end
    assert_equal "not allowed to RolePolicy#create? this Role", error.message
  end

  test "admin can create role" do
    sign_in admin

    post "/roles", params: { role: { name: "test1" } }
    assert_response :created
    assert JSON.parse(Role.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify role" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/roles/#{role.id}", params: { role: { name: "test1" } }
    end
    assert_equal "not allowed to RolePolicy#update? this Role", error.message
  end

  test "admin can modify role" do
    sign_in admin

    patch "/roles/#{role.id}", params: { role: { name: "test1" } }
    assert_response :ok
    assert JSON.parse(Role.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete role" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/roles/#{role.id}"
    end
    assert_equal "not allowed to RolePolicy#destroy? this Role", error.message
  end

  test "admin can delete role" do
    sign_in admin

    delete "/roles/#{role.id}"
    assert_response :see_other
    refute JSON.parse(Role.all.to_json).include? JSON.parse(role.to_json)
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def role
    @role ||= roles :athlete
  end
end

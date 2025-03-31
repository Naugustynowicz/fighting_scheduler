require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see users list" do
    sign_in user

    get "/users"
    assert JSON.parse(response.body).include? JSON.parse(user.to_json)
  end

  test "user can see its own profil" do
    sign_in user

    get "/users/#{user.id}"
    assert_equal JSON.parse(response.body), JSON.parse(user.to_json)
  end

  test "user cannot see other's profil" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/users/#{other_user.id}"
    end
    assert_equal "not allowed to UserPolicy#show? this User", error.message
  end

  test "admin can see any user profil" do
    sign_in admin

    get "/users/#{user.id}"
    assert_equal JSON.parse(response.body), JSON.parse(user.to_json)
  end

  test "anyone can create an user" do
    post "/signup", params: PAYLOAD
    assert_response :ok
    assert User.find_by(email: PAYLOAD[:user][:email]).present?
  end

  test "anyone can update own profil" do
    sign_in user

    patch "/users/#{user.id}", params: { user: { name: "test" } }
    user.reload
    assert_equal "test", user.name
  end

  test "cannot update other's profil" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/users/#{other_user.id}", params: { user: { name: "test" } }
    end
    assert_equal "not allowed to UserPolicy#update? this User", error.message
    other_user.reload
    assert_equal "ann", other_user.name
  end

  test "admin can modify any user" do
    sign_in admin

    patch "/users/#{user.id}", params: { user: { name: "test" } }
    assert_response :ok
    user.reload
    assert_equal "test", user.name
  end

  test "standard user cannot delete user" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/users/#{user.id}"
    end
    assert_equal "not allowed to UserPolicy#destroy? this User", error.message
  end

  test "admin can delete user" do
    sign_in admin

    delete "/users/#{user.id}"
    assert_response :see_other
    refute JSON.parse(User.all.to_json).include? JSON.parse(user.to_json)
  end

  test "admin cannot delete itself" do
    sign_in admin

    assert_raises Pundit::NotAuthorizedError do
      delete "/users/#{admin.id}"
    end
    assert User.find(admin.id).present?
  end

  private

  def user
    @user ||= users :bob
  end

  def other_user
    @other_user ||= users :ann
  end

  def admin
    @admin ||= users :admin
  end

  PAYLOAD = {
    user: {
      email: "test@email.com",
      password: "abcdef"
    }
  }.freeze
end

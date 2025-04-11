require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   test "everyone can see clubs list" do
    sign_in user

    get "/clubs"
    assert JSON.parse(response.body).include? JSON.parse(club.to_json)
  end

  test "normal user can't see club details" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      get "/clubs/#{club.id}"
    end
    assert_equal "not allowed to ClubPolicy#show? this Club", error.message
  end

  test "admin can see club details" do
    sign_in admin

    get "/clubs/#{club.id}"
    assert_equal JSON.parse(response.body), JSON.parse(club.to_json)
  end

  test "standard user cannot create club" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      post "/clubs", params: { club: { name: "test1", description: "description1" } }
    end
    assert_equal "not allowed to ClubPolicy#create? this Club", error.message
  end

  test "admin can create club" do
    sign_in admin

    post "/clubs", params: { club: { name: "test1", description: "description1" } }
    assert_response :created
    assert JSON.parse(Club.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify club" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/clubs/#{club.id}", params: { club: { name: "test1", description: "description1" } }
    end
    assert_equal "not allowed to ClubPolicy#update? this Club", error.message
  end

  test "admin can modify club" do
    sign_in admin

    patch "/clubs/#{club.id}", params: { club: { name: "test1", description: "description1" } }
    assert_response :ok
    assert JSON.parse(Club.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete club" do
    sign_in user

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/clubs/#{club.id}"
    end
    assert_equal "not allowed to ClubPolicy#destroy? this Club", error.message
  end

  test "admin can delete club" do
    sign_in admin

    delete "/clubs/#{club.id}"
    assert_response :see_other
    refute JSON.parse(Club.all.to_json).include? JSON.parse(club.to_json)
  end

  test "admin can add training to club" do
    sign_in admin

    post "/events", params: {
      event: {
        name: "training1",
        description: "whatdayawant",
        type_event_id: type_events(:training).id
      }
    }
    assert_response :created
    training = Event.find(JSON.parse(response.body)["id"])

    patch "/clubs/#{club.id}/add_training", params: { club: { event_id: training.id } }
    assert_response :ok
    training.reload
    assert_equal training.club_id, club.id

    patch "/clubs/#{club.id}/remove_training", params: { club: { event_id: training.id } }
    assert_response :ok
    training.reload
    assert_nil training.club_id, club.id
  end

  private

  def user
    @user ||= users :bob
  end

  def admin
    @admin ||= users :admin
  end

  def club
    @club ||= clubs :simple_club
  end
end

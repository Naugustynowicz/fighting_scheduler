require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    # because rails do not handle well constraints on renamed foreign key
    finale.update! previous_match_1: qualifier1.id, previous_match_2: qualifier2.id
  end

  test "everyone can see matches list" do
    sign_in user1

    get "/matches"
    assert JSON.parse(response.body).include? JSON.parse(qualifier1.to_json)
  end

  test "everyone can see match details" do
    sign_in user1

    get "/matches/#{qualifier1.id}"
    expected_payload = { match: qualifier1, user1: qualifier1.user1, user2: qualifier1.user2 }.to_json
    assert_equal JSON.parse(response.body), JSON.parse(expected_payload)
  end

  test "standard user cannot create match" do
    sign_in user1

    error = assert_raises Pundit::NotAuthorizedError do
      post "/matches", params: payload
    end
    assert_equal "not allowed to MatchPolicy#create? this Match", error.message
  end

  test "admin can create match" do
    sign_in admin

    post "/matches", params: payload
    assert_response :created
    assert JSON.parse(Match.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot modify match" do
    sign_in user1

    error = assert_raises Pundit::NotAuthorizedError do
      patch "/matches/#{qualifier1.id}", params: payload
    end
    assert_equal "not allowed to MatchPolicy#update? this Match", error.message
  end

  test "admin can modify match" do
    sign_in admin

    patch "/matches/#{qualifier1.id}", params: payload
    assert_response :ok
    assert JSON.parse(Match.all.to_json).include? JSON.parse(response.body)
  end

  test "standard user cannot delete match" do
    sign_in user1

    error = assert_raises Pundit::NotAuthorizedError do
      delete "/matches/#{qualifier1.id}"
    end
    assert_equal "not allowed to MatchPolicy#destroy? this Match", error.message
  end

  test "admin can delete match" do
    sign_in admin

    delete "/matches/#{qualifier1.id}"
    assert_response :see_other
    refute JSON.parse(Match.all.to_json).include? JSON.parse(qualifier1.to_json)
  end

  test "admin can update match infos" do
    sign_in admin

    patch "/matches/#{qualifier1.id}/determine_winner", params: { match: { winner: user1.id } }
    patch "/matches/#{qualifier2.id}/determine_winner", params: { match: { winner: user3.id } }
    qualifier1.reload
    qualifier2.reload
    get "/matches/#{finale.id}/update_match"
    finale.reload

    assert_equal qualifier1.winner, user1
    assert_equal qualifier2.winner, user3
    assert_equal finale.user1, user1
    assert_equal finale.user2, user3
  end

  test "user cannot update match infos" do
    sign_in user1

    patch "/matches/#{qualifier1.id}/determine_winner", params: { match: { winner: user1.id } }
    patch "/matches/#{qualifier2.id}/determine_winner", params: { match: { winner: user3.id } }
    get "/matches/#{finale.id}/update_match"

    assert_nil qualifier1.winner
    assert_nil qualifier2.winner
    assert_nil finale.user1
    assert_nil finale.user2
  end

  private

  def user1
    @user1 ||= users :bob
  end

  def user2
    @user2 ||= users :ann
  end

  def user3
    @user3 ||= users :jean
  end

  def user4
    @user4 ||= users :iris
  end

  def admin
    @admin ||= users :admin
  end

  def qualifier1
    @qualifier1 ||= matches :qualifier1
  end

  def qualifier2
    @qualifier2 ||= matches :qualifier2
  end

  def finale
    @finale ||= matches :finale
  end

  def event
    @event ||= events :simple_tournament
  end

  def payload
    return { # rubocop:disable Style/RedundantReturn
      match: {
        event_id: event.id,
        user1_id: user1.id,
        user2_id: user3.id,
        winner_id: nil,
        previous_match_1: nil,
        previous_match_2: nil
      }
    }
  end
end

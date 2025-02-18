require "test_helper"

class SportsControllerTest < ActionDispatch::IntegrationTest
  test "can create a record" do
    sports_path = "http://localhost:3000/sports"
    params = {
      name: "Sport name",
      description: "This is a description.",
      status: "public"
    }
    assert_difference "Sport.count", 1 do
      post sports_path, params: { sport: params }
    end

    assert_equal params[:name], Sport.last[:name]
    assert_equal params[:description], Sport.last[:description]
    assert_equal params[:status], Sport.last[:status]
  end
end

require "test_helper"

class SportTest < ActiveSupport::TestCase
  test "Could create sport" do
    sport = Sport.create!(
      name: "Sport1",
      description: "You could add some description here.",
      status: "public"
    )
    assert Sport.find(sport.id)
  end
end

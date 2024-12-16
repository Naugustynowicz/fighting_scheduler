require "test_helper"

class EvenementTest < ActiveSupport::TestCase
  test "Could create evenement" do
    evenement = Evenement.create!(
      type_event: "Tournament",
      start_date: DateTime.new(2024, 12, 16, 12, 22, 00),
      end_date: DateTime.new(2024, 12, 16, 12, 23, 00),
      attendees_nb: 2000,
      venue_fee: 10.99,
      status: "public",
      name: "Tournament1",
      description: "Some informations heres.",
      rules: "Explain ruleset here.",
      schedule: "When and where encounters will happenend.",
      brackets: "Tournament tree goes here.",
      locations_id: Location.first,
      sports_id: Sport.first
    )
    assert Evenement.find(evenement.id)
  end
end

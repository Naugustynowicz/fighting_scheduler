require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "Could create location" do
    location = Location.create!(
      name: "Location1",
      other: "Some misc infos",
      street: "01 StreetTest1 of Location1",
      city: "CityName1",
      postal_code: "12345",
      country: "CountryName1"
    )
    assert Location.find(location.id)
  end
end

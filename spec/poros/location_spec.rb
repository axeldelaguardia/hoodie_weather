require "rails_helper"

describe Location do
	let(:location) { Location.new({ adminArea5: "Denver", 
																	adminArea3: "CO", 
																	latLng: { 
																		lng: 105.54346, 
																		lat: 34.23953 } }) }

	it "exists" do
		expect(location).to be_a Location
	end

	it "has attributes" do
		expect(location.city).to be_a String
		expect(location.city).to eq("Denver")

		expect(location.state).to be_a String
		expect(location.state).to eq("CO")

		expect(location.longitude).to be_a Float
		expect(location.longitude).to eq(105.54346)

		expect(location.latitude).to be_a Float
		expect(location.latitude).to eq(34.23953)
	end
end
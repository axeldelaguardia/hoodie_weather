require "rails_helper"

describe "Map Quest Service" do
	it "get_long_lat", :vcr do
		service = MapQuestService.new

		response = service.get_long_lat("denver,co")

		expect(response).to be_a Hash

		expect(response).to have_key(:results)
		expect(response[:results]).to be_an Array

		response[:results].each do |result|
			expect(result).to have_key(:locations)
			expect(result[:locations]).to be_an Array

			result[:locations].each do |location|
				expect(location).to have_key(:latLng)
				expect(location[:latLng]).to be_a Hash

				expect(location[:latLng].keys).to match([:lat, :lng])

				expect(location[:latLng][:lat]).to be_a Float
				expect(location[:latLng][:lng]).to be_a Float
			end
		end
	end
end
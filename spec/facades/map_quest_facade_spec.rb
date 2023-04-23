require "rails_helper"

describe "Map Quest Facade" do
	it "it returns longitude and latitude when sending a get request", :vcr do
		params = {
			location: "Denver,CO"
		}

		@facade = MapQuestFacade.new(params)
		
		@facade.long_lat.each do |location|
			expect(location).to be_a Location

			expect(location).to respond_to(:city)
			expect(location).to respond_to(:state)
			expect(location).to respond_to(:longitude)
			expect(location).to respond_to(:latitude)
		end
	end
end
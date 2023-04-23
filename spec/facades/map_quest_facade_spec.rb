require "rails_helper"

describe "Map Quest Facade" do
	it "it returns longitude and latitude when sending a get request", :vcr do
		params = {
			location: "Denver,CO"
		}

		@facade = MapQuestFacade.new(params)

		expect(@facade.long_lat).to respond_to(:city)
		expect(@facade.long_lat).to respond_to(:state)
		expect(@facade.long_lat).to respond_to(:longitude)
		expect(@facade.long_lat).to respond_to(:latitude)
	end
end
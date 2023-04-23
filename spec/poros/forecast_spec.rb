require "rails_helper"

describe Forecast, :vcr do
	let(:facade) { WeatherFacade.new }
	let(:forecast) { facade.get_forecast("39.854938,-105.035477") }

	it "exists" do
		expect(forecast).to be_a Forecast
	end

	it "has_attributes" do
		expect(forecast).to respond_to(:current_weather)
		expect(forecast).to respond_to(:daily_weather)
		expect(forecast).to respond_to(:hourly_weather)
	end
end
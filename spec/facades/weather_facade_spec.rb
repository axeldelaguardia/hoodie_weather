require "rails_helper"

describe "Weather Facade", :vcr do
	let(:facade) { WeatherFacade.new }

	it "creates a weather object with all forecast for day, week, and hourly" do
		forecast = facade.get_forecast("39.854938,-105.035477")

		expect(forecast).to be_a Forecast
		expect(forecast).to respond_to(:current_weather)
		expect(forecast).to respond_to(:daily_weather)
		expect(forecast).to respond_to(:hourly_weather)
	end
end
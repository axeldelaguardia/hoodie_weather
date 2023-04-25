require "rails_helper"

describe "Weather Service", :vcr do
	let(:service) { WeatherService.new }

	it "returns JSON with the weather service for 5 days" do
		forecast = service.get_forecast("39.854938,-105.035477")

		expect(forecast).to be_a Hash
		expect(forecast).to have_key(:current)
		expect(forecast[:current]).to be_a Hash
		expect(forecast[:current].keys).to include(:last_updated, :temp_f, :feelslike_f,
																							:humidity, :uv, :vis_miles, :condition)
		expect(forecast[:current][:last_updated]).to be_a String
		expect(forecast[:current][:temp_f]).to be_a Float
		expect(forecast[:current][:feelslike_f]).to be_a Float
		expect(forecast[:current][:humidity]).to be_a Integer
		expect(forecast[:current][:uv]).to be_a Float
		expect(forecast[:current][:vis_miles]).to be_a Float
		
		expect(forecast[:current][:condition]).to be_a Hash
		expect(forecast[:current][:condition].keys).to include(:text, :icon)
		expect(forecast[:current][:condition][:text]).to be_a String
		expect(forecast[:current][:condition][:icon]).to be_a String

		expect(forecast).to have_key(:forecast)
		expect(forecast[:forecast]).to have_key(:forecastday)
		expect(forecast[:forecast][:forecastday]).to be_an Array

		forecast[:forecast][:forecastday].each do |day|
			expect(day.keys).to include(:date, :day, :astro, :hour)
			expect(day[:date]).to be_a String

			expect(day).to be_a Hash
			expect(day[:day]).to be_a Hash
			expect(day[:day].keys).to include(:maxtemp_f, :mintemp_f, :condition)
			expect(day[:day][:condition]).to be_a Hash
			expect(day[:day][:condition].keys).to include(:text, :icon)
			expect(forecast[:current][:condition][:text]).to be_a String
			expect(forecast[:current][:condition][:icon]).to be_a String
			
			expect(day[:astro]).to be_a Hash
			expect(day[:astro].keys).to include(:sunrise, :sunset)
			expect(day[:astro][:sunrise]).to be_a String
			expect(day[:astro][:sunset]).to be_a String

			expect(day[:hour]).to be_an Array

			day[:hour].each do |hour|
				expect(hour).to be_a Hash
				expect(hour.keys).to include(:time, :temp_f, :condition)
				expect(hour[:time]).to be_a String
				expect(hour[:temp_f]).to be_a Float
				expect(hour[:condition]).to be_a Hash
				expect(hour[:condition].keys).to include(:text, :icon)
				expect(hour[:condition][:text]).to be_a String
				expect(hour[:condition][:icon]).to be_a String
			end
		end
	end
end
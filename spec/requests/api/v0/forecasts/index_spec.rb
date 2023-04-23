require "rails_helper"

describe "Forecast Request", :vcr do
	describe "get forecast for a location" do
		it "returns forecast when parameters of location are sent" do
			get "/api/v0/forecast", params: {location: "Denver,CO"}

			expect(response).to be_successful

			response_body = JSON.parse(response.body, symbolize_names: true)

			expect(response_body).to have_key(:data)
			expect(response_body[:data]).to be_a Hash
			expect(response_body[:data].keys).to match([:id, :type, :attributes])

			expect(response_body[:data][:id]).to be nil

			expect(response_body[:data][:type]).to be_a String
			expect(response_body[:data][:type]).to eq("forecast")

			expect(response_body[:data][:attributes]).to be_a Hash
			expect(response_body[:data][:attributes].keys).to match([:current_weather, 
																															 :daily_weather, 
																															 :hourly_weather])

			attributes = response_body[:data][:attributes]

			expect(attributes[:current_weather]).to be_a Hash
			expect(attributes[:current_weather].keys).to match([:last_udpated, :temperature, 
																													:feels_like, :humidity, :uvi, 
																													:visibility, :condition, :icon])

			expect(attributes[:daily_weather]).to be_an Array

			attributes[:daily_weather].each do |daily_weather|
				expect(daily_weather).to be_a Hash
				expect(daily_weather.keys).to match([:date, :sunrise, :sunset, 
																						 :max_temp, :min_temp, 
																						 :condition, :icon])
				expect(daily_weather[:date]).to be_a String
				expect(daily_weather[:sunrise]).to be_a String
				expect(daily_weather[:sunset]).to be_a String
				expect(daily_weather[:max_temp]).to be_a Float
				expect(daily_weather[:min_temp]).to be_a Float
				expect(daily_weather[:condition]).to be_a String
				expect(daily_weather[:icon]).to be_a String
			end

			expect(attributes[:hourly_weather]).to be_an Array
			
			attributes[:hourly_weather].each do |hour|
				expect(hour).to be_a Hash
				expect(hour.keys).to match([:time, :temperature, 
																		:condition, :icon])
				expect(hour[:time]).to be_a String
				expect(hour[:temperature]).to be_a Float
				expect(hour[:condition]).to be_a String
				expect(hour[:icon]).to be_a String
			end
		end
	end
end
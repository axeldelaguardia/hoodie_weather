require "rails_helper"

describe "Road Trip Request", :vcr do
	let!(:user) { create(:user, api_key: "test_key") }

	it "returns road trip data for destination provided" do
		params = { 
			"origin": "Cincinnati, OH",
			"destination": "Chicago, IL",
			"api_key": user.api_key
		}

		post api_v0_road_trip_path, headers: {"Content_Type": "application/json"}, params: params

		expect(response).to be_successful

		response_body = JSON.parse(response.body, symbolize_names: true)
		expect(response_body).to have_key(:data)
		expect(response_body[:data]).to be_a Hash
		expect(response_body[:data].keys).to match([:id, :type, :attributes])

		expect(response_body[:data][:id]).to eq nil

		expect(response_body[:data][:type]).to be_a String
		expect(response_body[:data][:type]).to eq("road_trip")

		expect(response_body[:data][:attributes]).to be_a Hash
		expect(response_body[:data][:attributes].keys).to match([:start_city, :end_city, :travel_time, :weather_at_eta])

		attributes = response_body[:data][:attributes]

		expect(attributes[:start_city]).to be_a String
		expect(attributes[:start_city]).to eq(params[:origin])

		expect(attributes[:end_city]).to be_a String
		expect(attributes[:end_city]).to eq(params[:destination])

		expect(attributes[:travel_time]).to be_a String
		expect(attributes[:travel_time]).to eq("04:43:18")

		expect(attributes[:weather_at_eta]).to be_a Hash
		expect(attributes[:weather_at_eta].keys).to match([:datetime, :temperature, :condition])
		expect(attributes[:weather_at_eta][:datetime]).to be_a String
		expect(attributes[:weather_at_eta][:datetime]).to eq("2023-04-25 15:00")
		expect(attributes[:weather_at_eta][:temperature]).to be_a Float
		expect(attributes[:weather_at_eta][:temperature]).to eq(41.5)
		expect(attributes[:weather_at_eta][:condition]).to be_a String
		expect(attributes[:weather_at_eta][:condition]).to eq("Overcast")

	end
end
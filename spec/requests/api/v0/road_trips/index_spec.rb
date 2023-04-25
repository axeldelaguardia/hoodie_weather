require "rails_helper"

describe "Road Trip Request" do
	let!(:user) { create(:user, api_key: "test_key") }
	before do
		allow(DateTime).to receive(:now).and_return(DateTime.parse("2023-04-25 11:42 -0600"))
	end

	it "returns road trip data for destination provided", :vcr do
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
		expect(attributes[:weather_at_eta][:datetime]).to eq("2023-04-25 17:00")
		expect(attributes[:weather_at_eta][:temperature]).to be_a Float
		expect(attributes[:weather_at_eta][:temperature]).to eq(41.9)
		expect(attributes[:weather_at_eta][:condition]).to be_a String
		expect(attributes[:weather_at_eta][:condition]).to eq("Cloudy")
	end

	it "returns road trip data for a different destination provided", :vcr do
		params = { 
			"origin": "New York, NY",
			"destination": "Los Angeles, CA",
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
		expect(attributes[:travel_time]).to eq("40:10:51")

		expect(attributes[:weather_at_eta]).to be_a Hash
		expect(attributes[:weather_at_eta].keys).to match([:datetime, :temperature, :condition])
		expect(attributes[:weather_at_eta][:datetime]).to be_a String
		expect(attributes[:weather_at_eta][:datetime]).to eq("2023-04-27 02:00")
		expect(attributes[:weather_at_eta][:temperature]).to be_a Float
		expect(attributes[:weather_at_eta][:temperature]).to eq(65.7)
		expect(attributes[:weather_at_eta][:condition]).to be_a String
		expect(attributes[:weather_at_eta][:condition]).to eq("Clear")
	end

	it "returns road trip data for a longer destination provided", :vcr do
		params = { 
			"origin": "New York, NY",
			"destination": "Panama City, Panama",
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
		expect(attributes[:end_city]).to eq("Ciudad de Panamá, PA-8")

		expect(attributes[:travel_time]).to be_a String
		expect(attributes[:travel_time]).to eq("80:30:16")

		expect(attributes[:weather_at_eta]).to be_a Hash
		expect(attributes[:weather_at_eta].keys).to match([:datetime, :temperature, :condition])
		expect(attributes[:weather_at_eta][:datetime]).to be_a String
		expect(attributes[:weather_at_eta][:datetime]).to eq("2023-04-28 21:00")
		expect(attributes[:weather_at_eta][:temperature]).to be_a Float
		expect(attributes[:weather_at_eta][:temperature]).to eq(78.4)
		expect(attributes[:weather_at_eta][:condition]).to be_a String
		expect(attributes[:weather_at_eta][:condition]).to eq("Clear")
	end

	it "returns impossible if destination cant be reached", :vcr do
		params = { 
			"origin": "New York, NY",
			"destination": "London, UK",
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
		expect(attributes[:end_city]).to eq("London, UK")

		expect(attributes[:travel_time]).to be_a String
		expect(attributes[:travel_time]).to eq("impossible")

		expect(attributes[:weather_at_eta]).to be_a Hash
		expect(attributes[:weather_at_eta].empty?).to be_truthy
		expect(attributes[:weather_at_eta].keys).to match([])
	end

	it "returns error when origin is missing", :vcr do
		params = { 
			"destination": "London, UK",
			"api_key": user.api_key
		}

		post api_v0_road_trip_path, headers: {"Content_Type": "application/json"}, params: params

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to be_a String
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to be_a String
		expect(response_body[:error]).to eq("params must be included")
	end

	it "returns error when destination is missing", :vcr do
		params = { 
			"origin": "New York, NY",
			"api_key": user.api_key
		}

		post api_v0_road_trip_path, headers: {"Content_Type": "application/json"}, params: params

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to be_a String
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to be_a String
		expect(response_body[:error]).to eq("params must be included")
	end

	it "returns error when api is missing", :vcr do
		params = { 
			"origin": "New York, NY",
			"destination": "London, UK"
		}

		post api_v0_road_trip_path, headers: {"Content_Type": "application/json"}, params: params

		expect(response).to have_http_status 401

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to be_a String
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to be_a String
		expect(response_body[:error]).to eq("api_key is not valid")
	end

	it "returns error when api is incorrect", :vcr do
		params = { 
			"origin": "New York, NY",
			"destination": "London, UK",
			"api_key": "incorrect_api_key"
		}

		post api_v0_road_trip_path, headers: {"Content_Type": "application/json"}, params: params

		expect(response).to have_http_status 401

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to be_a String
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to be_a String
		expect(response_body[:error]).to eq("api_key is not valid")
	end
end
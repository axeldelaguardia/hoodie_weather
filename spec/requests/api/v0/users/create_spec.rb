require "rails_helper"

describe "User Create Request", :vcr do
	it "creates a user and returns it with api key" do
		user = { 
			email: "whatever@example.com", 
			password: "password",
			password_confirmation: "password" 
		}
		post "/api/v0/users", params: JSON.generate(user),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to be_successful

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body.keys).to match([:data])
		expect(response_body[:data]).to be_a Hash

		expect(response_body[:data].keys).to match([:id, :type, :attributes])

		expect(response_body[:data][:id]).to be_a String

		expect(response_body[:data][:type]).to be_a String
		expect(response_body[:data][:type]).to eq("user")

		expect(response_body[:data][:attributes]).to be_a Hash
		expect(response_body[:data][:attributes].keys).to match([:email, :api_key])
		expect(response_body[:data][:attributes][:email]).to be_a String
		expect(response_body[:data][:attributes][:api_key]).to be_a String
	end

	it "returns an error when passwords don't match" do
		user = { 
			email: "whatever@example.com", 
			password: "password",
			password_confirmation: "different_password" 
		}
		post "/api/v0/users", params: JSON.generate(user),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash

		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to eq("passwords don't match")
	end

	it "returns an error when email has already been taken" do
		User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
		user = { 
			email: "whatever@example.com", 
			password: "password",
			password_confirmation: "password" 
		}
		post "/api/v0/users", params: JSON.generate(user),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash

		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to eq("Email has already been taken")
	end

	it "returns an error when the email is not valid" do

	end

	it "returns an error when there is an empty field" do

	end
end
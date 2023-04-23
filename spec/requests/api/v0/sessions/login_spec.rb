require "rails_helper"

describe "Sessions Login" do
	let!(:user) { User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password") }

	it "authenticates a user" do
		userx = { 
			email: "whatever@example.com", 
			password: "password"
		}
		post api_v0_sessions_path, params: JSON.generate(userx),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to be_successful

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body).to have_key(:data)
		expect(response_body[:data]).to be_a Hash
		expect(response_body[:data].keys).to match([:id, :type, :attributes])

		expect(response_body[:data][:id]).to eq(user.id.to_s)
		expect(response_body[:data][:type]).to eq("user")

		expect(response_body[:data][:attributes]).to be_a Hash
		expect(response_body[:data][:attributes].keys).to match([:email, :api_key])
		expect(response_body[:data][:attributes][:email]).to eq(user.email)
		expect(response_body[:data][:attributes][:api_key]).to eq(user.api_key)
	end

	it "returns an error if password is incorrect" do
		userx = { 
			email: "whatever@example.com", 
			password: "password2"
		}
		post api_v0_sessions_path, params: JSON.generate(userx),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash

		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to eq("Email or Password are incorrect")
	end

	it "returns an error if email is not found" do
		userx = { 
			email: "whatever123@example.com", 
			password: "password1"
		}
		post api_v0_sessions_path, params: JSON.generate(userx),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash

		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to eq("Email or Password are incorrect")
	end

	it "returns an error if missing email field" do
		userx = { 
			password: "password1"
		}
		post api_v0_sessions_path, params: JSON.generate(userx),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash

		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to eq("Email or Password are incorrect")
	end

	it "returns an error if missing password field" do
		userx = { 
			email: "whatever@example.com"
		}
		post api_v0_sessions_path, params: JSON.generate(userx),
													headers: {
														"Content-Type": "application/json",
														"Accept": "application/json"
													}

		expect(response).to have_http_status 400

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash

		expect(response_body.keys).to match([:message, :error])
		expect(response_body[:message]).to eq("your query could not be completed")
		expect(response_body[:error]).to eq("Email or Password are incorrect")
	end
end
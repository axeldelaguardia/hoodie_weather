require "rails_helper"

describe "Salaries Request", :vcr do
	it "returns json data with destination, current weather and salaries" do
		get api_v0_salaries_path, params: { destination: "denver" }

		expect(response).to be_successful

		response_body = JSON.parse(response.body, symbolize_names: true)

		expect(response_body).to be_a Hash
		expect(response_body).to have_key(:data)
		expect(response_body[:data]).to be_a Hash
		expect(response_body[:data].keys).to match([:id, :type, :attributes])
		expect(response_body[:data][:id]).to eq(nil)
		expect(response_body[:data][:type]).to eq("salaries")

		attributes = response_body[:data][:attributes]

		expect(attributes).to be_a Hash
		expect(attributes.keys).to match([:destination, :forecast, :salaries])
		
		expect(attributes[:destination]).to be_a String
		expect(attributes[:destination]).to eq("denver")

		expect(attributes[:forecast].keys).to eq([:summary, :temperature])
		expect(attributes[:forecast][:summary]).to be_a String
		expect(attributes[:forecast][:summary]).to eq("Partly cloudy")
		expect(attributes[:forecast][:temperature]).to be_a Float
		expect(attributes[:forecast][:temperature]).to eq(45.7)

		expect(attributes[:salaries]).to be_an Array
		attributes[:salaries].each do |salary|
			expect(salary).to be_a Hash
			expect(salary.keys).to match([:title, :min, :max])
			expect(salary[:title]).to be_a String
			expect(salary[:min]).to be_a String
			expect(salary[:max]).to be_a String
		end
	end
end
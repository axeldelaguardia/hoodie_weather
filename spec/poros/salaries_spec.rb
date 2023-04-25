require "rails_helper"

describe Salaries, :vcr do
	let(:salary) { TeleportFacade.new }

	it "returns all salaries for specific jobs" do
		salaries = salary.get_salaries("denver")

		expect(salaries).to be_a Salaries
		
		expect(salaries).to respond_to(:id)
		expect(salaries).to respond_to(:forecast)
		expect(salaries).to respond_to(:destination)
		expect(salaries).to respond_to(:salaries)

		expect(salaries.id).to eq(nil)

		expect(salaries.forecast).to be_a Hash
		expect(salaries.forecast.keys).to match([:summary, :temperature])
		expect(salaries.forecast[:summary]).to be_a String
		expect(salaries.forecast[:temperature]).to be_a Float

		expect(salaries.destination).to be_a String

		expect(salaries.salaries).to be_an Array

		salaries.salaries.each do |salary|
			expect(salary.keys).to match([:title, :min, :max]) 
			expect(salary[:title]).to be_a String
			expect(salary[:min]).to be_a String
			expect(salary[:max]).to be_a String
		end
	end
end
require "rails_helper"

describe "Teleport Service", :vcr do
		let(:service) { TeleportService.new }

		it "returns json data with salaries for a specific city" do
			response_body = service.get_salaries("denver")

			expect(response_body).to be_a Hash
			expect(response_body.keys).to match([:_links, :salaries])
			expect(response_body[:salaries]).to be_an Array
			
			response_body[:salaries].each do |salary|
				expect(salary).to be_a Hash
				expect(salary.keys).to match([:job, :salary_percentiles])
				
				expect(salary[:job]).to be_a Hash
				expect(salary[:job].keys).to match([:id, :title])
				expect(salary[:job][:id]).to be_a String
				expect(salary[:job][:title]).to be_a String

				expect(salary[:salary_percentiles]).to be_a Hash
				expect(salary[:salary_percentiles].keys).to match([:percentile_25, :percentile_50, :percentile_75])
				expect(salary[:salary_percentiles][:percentile_25]).to be_a Float
				expect(salary[:salary_percentiles][:percentile_50]).to be_a Float
				expect(salary[:salary_percentiles][:percentile_75]).to be_a Float
			end
		end
end
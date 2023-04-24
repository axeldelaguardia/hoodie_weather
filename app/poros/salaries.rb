class Salaries
	attr_reader :destination,
							:forecast,
							:salaries

	def initialize(destination, jobs)
		@destination = destination
		@forecast = Weather
		@salaries = parse_salary_data(jobs)
	end

	def weather_in_city

	end

	def parse_salary_data(jobs)
		jobs.map do |job|
			{
				title: job[:job][:title],
				min: job[:salary_percentiles][:percentile_25],
				max: job[:salary_percentiles][:percentile_75]
			}
		end
	end

	def weather_data()
end
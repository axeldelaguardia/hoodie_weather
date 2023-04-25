class Salaries
	attr_reader :id,
							:destination,
							:forecast,
							:salaries

	def initialize(destination, jobs)
		@id = nil
		@destination = destination
		@forecast = weather_data(destination)
		@salaries = parse_salary_data(jobs)
	end

	def parse_salary_data(jobs)
		jobs.map do |job|
			{
				title: job[:job][:title],
				min: helpers.number_to_currency(job[:salary_percentiles][:percentile_25]),
				max: helpers.number_to_currency(job[:salary_percentiles][:percentile_75])
			}
		end
	end

	def weather_data(destination)
		coordinates = MapQuestFacade.new(location: destination).long_lat
		forecast = WeatherFacade.new.get_forecast(coordinates.lat_lng)
		{
			summary: forecast.current_weather[:condition],
			temperature: forecast.current_weather[:temperature]
		}
	end

	def helpers
		ActionController::Base.helpers
	end
end
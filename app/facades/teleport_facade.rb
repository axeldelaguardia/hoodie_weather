class TeleportFacade

	def initialize(params = {})
		@params = params
	end

	def service
		@service ||= TeleportService.new
	end

	def get_salaries(city)
		data = service.get_salaries(city)
		require 'pry'; binding.pry
		jobs = data[:salaries].select do |job|
			["Data Analyst", "Data Scientist", "Mobile Developer",
			 "QA Engineer", "Software Engineer", "Systems Administrator",
			 "Web Developer"].include?(job[:job][:title])
		end
		
		salaries = Salaries.new(city, jobs)
	end
end
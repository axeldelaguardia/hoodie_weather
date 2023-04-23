class MapQuestFacade
	attr_reader :city_state

	def initialize(params = {})
		@city_state = params[:location]
	end

	def long_lat
		data = service.get_long_lat(@city_state)
		lat_lng = data[:results].map do |result|
			result[:locations].map do |location|
				Location.new(location)
			end
		end.flatten
	end

	def service
		@service ||= MapQuestService.new
	end
end
class MapQuestFacade
	def initialize(params = {})
		@city_state = params[:location]
	end

	def long_lat
		data = service.get_long_lat(@city_state)
		lat_lng = data[:results].map do |result|
			result[:locations].map do |location|
				Location.new(location)
			end
		end.flatten.first
	end

	def road_trip(to, from)
		data = service.get_directions(to, from)
		if data[:info][:messages].empty?
			RoadTrip.new(data[:route])
		else
			RoadTrip.new(to: to, from: from)
		end
	end

	def service
		@service ||= MapQuestService.new
	end
end
class RoadTrip
	attr_reader :id,
							:start_city,
							:end_city,
							:travel_time,
							:weather_at_eta

	def initialize(data={})
		@id = nil
		if data[:locations]
			@start_city = "#{data[:locations].first[:adminArea5]}, #{data[:locations].first[:adminArea3]}"
			@end_city = "#{data[:locations].second[:adminArea5]}, #{data[:locations].second[:adminArea3]}"
			@travel_time = data[:formattedTime]
			@weather_at_eta = get_weather(@travel_time, data[:locations].second[:latLng].values.join(", "))
		else
			@start_city = data[:from]
			@end_city = data[:to]
			@travel_time = "impossible"
			@weather_at_eta = {}
		end
	end

	def get_weather(travel_time, coordinates)
		eta_time = convert_time(travel_time)
		forecast = WeatherFacade.new.get_forecast_for(eta_time.to_i, coordinates)
		{
			"datetime": forecast.date_time,
			"temperature": forecast.temperature,
			"condition": forecast.condition
		}
	end

	def convert_time(time)
		seconds = convert_to_seconds(time)
		now = DateTime.now.to_time
		time = now + seconds
		if time.min >= 30
			time = time.change(min: 00).strftime("%s")
		else
			time.change(min: 00).strftime("%s")
		end
	end

	def convert_to_seconds(time)
		time = time.split(":")
		time.first.to_f * 3600 + time.second.to_f * 60 + time.third.to_f
	end
end
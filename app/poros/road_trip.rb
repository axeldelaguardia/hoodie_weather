class RoadTrip
	attr_reader :id,
							:start_city,
							:end_city,
							:travel_time,
							:weather_at_eta

	def initialize(data)
		@id = nil
		@start_city = "#{data[:locations].first[:adminArea5]}, #{data[:locations].first[:adminArea3]}"
		@end_city = "#{data[:locations].second[:adminArea5]}, #{data[:locations].second[:adminArea3]}"
		@travel_time = data[:formattedTime]
		@weather_at_eta = get_weather(@travel_time, data[:locations].second[:latLng].values.join(", "))
	end

	def get_weather(travel_time, coordinates)
		forecast = WeatherFacade.new.get_forecast(coordinates)
		eta_time = convert_time(travel_time)
		weather = forecast.hourly_weather.find do |time|
			time[:time] == eta_time.strftime("%H:%M")
		end
		{
			"datetime": eta_time.strftime("%Y-%m-%d %H:%M"),
			"temperature": weather[:temperature],
			"condition": weather[:condition]
		}
	end

	def convert_time(time)
		time = time.to_time
		seconds = (time.hour * 60 * 60) + (time.min * 60)
		now = DateTime.now.to_time
		time = now + seconds
		if time.min >= 30
			time.change(hour: time.hour + 1, min: 00)
		else
			time.change(min: 00)
		end
	end
end
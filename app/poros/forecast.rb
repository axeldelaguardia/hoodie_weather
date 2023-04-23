class Forecast
	attr_reader :id,
							:current_weather,
							:daily_weather,
							:hourly_weather
							
	def initialize(info)
		@id = nil
		@location = info[:location]
		@current_weather = get_current_weather(info[:current])
		@daily_weather = get_daily_weather(info[:forecast][:forecastday])
		@hourly_weather = get_hourly_weather(info[:forecast][:forecastday].first)
	end

	def get_current_weather(data)
		{
			last_udpated: data[:last_updated],
			temperature: data[:temp_f],
			feels_like: data[:feelslike_f],
			humidity: data[:humidity],
			uvi: data[:uv],
			visibility: data[:vis_miles],
			condition: data[:condition][:text],
			icon: data[:condition][:icon]
		}
	end

	def get_daily_weather(data)
		data.map do |day|
			{
				date: day[:date],
				sunrise: day[:astro][:sunrise],
				sunset: day[:astro][:sunset],
				max_temp: day[:day][:maxtemp_f],
				min_temp: day[:day][:mintemp_f],
				condition: day[:day][:condition][:text],
				icon: day[:day][:condition][:icon]
			}
		end
	end

	def get_hourly_weather(data)
		data[:hour].map do |hour|
			{
				time: hour[:time][-5..-1],
				temperature: hour[:temp_f],
				condition: hour[:condition][:text],
				icon: hour[:condition][:icon]
			}
		end
	end
end
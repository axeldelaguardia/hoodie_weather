class DestinationWeather
	attr_reader :date_time,
							:temperature,
							:condition

	def initialize(weather)
		@date_time = weather[:time]
		@temperature = weather[:temp_f]
		@condition = weather[:condition][:text]
	end
end
class Location
	attr_reader :city,
							:state,
							:longitude,
							:latitude

	def initialize(info)
		@city = info[:adminArea5]
		@state = info[:adminArea3]
		@longitude = info[:latLng][:lng]
		@latitude = info[:latLng][:lat]
	end

	def lat_lng
		[@latitude, @longitude].join(",")
	end
end
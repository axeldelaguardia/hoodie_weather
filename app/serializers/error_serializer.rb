class ErrorSerializer
  include JSONAPI::Serializer
  
	def self.custom(message)
		{
			message: "your query could not be completed",
			error: message 
		}
	end
end

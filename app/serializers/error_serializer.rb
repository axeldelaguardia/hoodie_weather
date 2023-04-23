class ErrorSerializer  
	def self.custom(message)
		{
			message: "your query could not be completed",
			error: message 
		}
	end

	def self.model_error(errors)
		{
			message: "your query could not be completed",
			error: errors.full_messages.join(", ")
		}
	end
end

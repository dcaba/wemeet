module WeMeet
	class Message
		attr_accessor :message,:creator,:date
		def initialize(message,creator=caller)
			@message = message
			@creator = creator
			@date = Time.now
		end
	end


end

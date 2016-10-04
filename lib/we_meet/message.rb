module WeMeet
	class Message
		attr_accessor :content,:creator,:date
		def initialize(content,creator=caller)
			@content = content
			@creator = creator
			@date = Time.now
		end
	end


end

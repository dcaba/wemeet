
module WeMeet
	GADDRESS_SUFFIX="wemeet.com"
	class Group
		attr_accessor :name
		attr_reader :owner

		def initialize(name,owner)
			@name = name.chomp
			@owner = owner
		end

		def email
			"#{name.downcase.tr(" ",".")}@#{GADDRESS_SUFFIX}"
		end
	end
end

require_relative 'user'

module WeMeet
	GADDRESS_SUFFIX="wemeet.com"
	class Group
		attr_accessor :name
		attr_reader :owner

		def initialize(name,owner)
			@name = name.chomp
			@owner = owner
			@members = [owner]
		end

		def email
			"#{name.downcase.tr(" ",".")}@#{GADDRESS_SUFFIX}"
		end

		def has_member?(user)
			return @members.include? user
		end

		def to_s
			"#{@name} group managed by #{@owner} with #{@members.size} members" 
		end
	end
end

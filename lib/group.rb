require_relative 'user'
require_relative 'message'

module WeMeet
	GADDRESS_SUFFIX="wemeet.com"
	class Group
		attr_accessor :name
		attr_reader :owner

		def initialize(name,owner)
			@name = name.chomp
			@owner = owner
			@members = [owner]
			@messages = Array.new
		end

		def email
			"#{name.downcase.tr(" ",".")}@#{GADDRESS_SUFFIX}"
		end

		def add_member(user)
			@members << user unless has_as_member?(user)
		end

		def has_as_member?(user)
			return @members.include? user
		end

		def each_member
			@members.each { |member| yield member }
		end	

		def swap_ownership
			@members.length == 1 ? raise("Owner is the only member") : @owner = (@members - [@owner]).sample 
		end

		def leave(user)
			swap_ownership if @owner == user 
			@members.delete(user)
		end

		def send_message(message)
			@messages << message
		end

		def get_messages
			@messages
		end
		def to_s
			"#{@name} group managed by #{@owner} with #{@members.size} members" 
		end
	end
end

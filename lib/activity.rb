module WeMeet

	class Activity
		attr_accessor :name, :aliases
		def initialize(name)
			@name = name
			@aliases = [name.downcase]
		end
		
		def alias(aname)
			@aliases << aname.downcase unless @aliases.include? aname.downcase
		end

		def similar_to?(other)
			found = false
			@aliases.each do |as|
				found = true if as.include? other.downcase
			end
			return found
		end
	end
end

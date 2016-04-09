require_relative "activity_category"

module WeMeet

	class Activity
		attr_accessor :name, :category

		def initialize(name,category=nil)
			@name = name
			@aliases = Hash.new
			@aliases[name.downcase] = name
			@category = category
		end
		
		def alias(aname)
			@aliases[aname.downcase] = aname unless (@aliases.keys + @aliases.values).include? aname.downcase
		end

		def aliases
			@aliases.values
		end

		def similar_to?(other)
			found = false
			@aliases.keys.each do |as|
				found = true if as.include? other.downcase
			end
			return found
		end
	end
end

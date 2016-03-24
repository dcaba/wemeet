module WeMeet

	class Activity
		attr_accessor :name
		def initialize(name)
			@name = name
		end
		def similar_to?(other)
			return @name.downcase.include? other.downcase
		end
	end
end

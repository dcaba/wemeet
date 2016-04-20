module WeMeet
	class ActivityCategory
		attr_accessor :name

		def initialize(name)
			@name = name.capitalize
		end

		def similar_to?(other)
			return @name.downcase.include? other.downcase
		end

		def ==(other)
			return @name.downcase == other.name.downcase
		end
	end
end

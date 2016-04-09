module WeMeet
	ActivityCategory = Struct.new(:name)

	class ActivityCategory
		def new(name)
			super name.capitalize
		end

		def similar_to?(other)
			return @name.downcase.include? other.downcase
		end
	end
end

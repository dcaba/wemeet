require_relative 'activity'
require 'singleton'

module WeMeet
	class Activities < Array
		include Singleton

		def search(term)
			return self.select {|act| act.similar_to? term}
		end
	end
end

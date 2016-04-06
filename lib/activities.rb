require_relative 'activity'
require 'singleton'

module WeMeet
	class Activities < Array
		include Singleton

		def search(term)
			return self.select {|act| act.similar_to? term}
		end

		def remove(term)
			self.reject! { |act| act.name == term }
			return
		end

		def clean
			self.reject! { true}
		end

		def list
			activities_name = []
			self.each { |act| activities_name << act.name }
			return activities_name
		end
	end
end

require_relative 'activity'
require 'singleton'

module WeMeet
	class Activities < Array
		include Singleton
		def initialize
			@categories = Array.new
			super
		end

		def <<(activity)
			register_category(activity.category) unless activity.category.nil?
			super
		end

		def search(term,category=nil)
			return self.select {|act| act.similar_to? term and category == act.category}
		end

		def remove(term)
			self.reject! { |act| act.name == term }
			return
		end

		def register_category(category)
			@categories << category unless search_categories category
		end
		def list_categories
			@categories
		end

		def search_categories(category)
			found = false
			@categories.each {|cat| found = true if cat.name.downcase == category.name.downcase}
			return found
		end

		def clean
			self.reject! { true}
		end

		def list(category=nil)
			activities = []
			self.each { |act| activities << act }
			return activities
		end
	end
end

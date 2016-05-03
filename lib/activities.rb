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
			search_by_activity(activity) != [] ? raise("Activity already exists") : super
		end

		def search_by_term(term,category=nil)
			return self.select {|act| act.similar_to? term and (category == act.category or category.nil?)}
		end

		def search_by_activity(activity)
			rs1 = search_by_term(activity.name,activity.category)
			activity.aliases.each {|alis| search_by_term(alis,activity.category).each {|found| rs1 << found} }
			return rs1
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
			@categories.each {|cat| found = true if cat == category}
			return found
		end

		def clean
			self.reject! { true }
		end

		def list(category=nil)
			activities = []
			self.each { |act| activities << act if category.nil? or act.category == category}
			return activities
		end
	end
end

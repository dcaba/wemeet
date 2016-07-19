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
			begin
				register_category(activity.category) unless activity.category.nil?
			rescue RuntimeError
				# that's just fine. It may already exist
			end
			search_by_activity(activity) != [] ? raise("Activity already exists") : super
		end

		def search_by_term(term,category=nil)
			return self.select {|act| act.similar_to? term and (category == act.category or category.nil?)}
		end

		def search_by_activity(activity)
			rs1 = search_by_term(activity.name,activity.category)
			activity.aliases.each {|alias_name| search_by_term(alias_name,activity.category).each {|found| rs1 << found} }
			return rs1
		end

		def remove(term)
			self.reject! { |act| act.similar_to? term }
			return
		end

		def register_category(category)
			search_categories(category) ? raise("Category already exists") : @categories << category
		end

		def list_categories
			@categories
		end

		def search_categories(category)
			found = false
			@categories.each {|cat| found = true if cat.similar_to? category.name}
			return found
		end

		def remove_category(category)
			raise("Category still associated to a registered activity") if search_by_term("",category) != []
			@categories.reject! {|cat| cat == category }
		end

		def clean
			self.reject! { true }
			@categories = Array.new
		end

		def list(category=nil)
			activities = []
			self.each { |act| activities << act if category.nil? or act.category.similar_to? category.name}
			return activities
		end
	end
end

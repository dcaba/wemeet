require_relative 'group'
require 'securerandom'

module WeMeet
	User = Struct.new(:name,:surname,:email,:password)
	def self.capitalize_sentence(sentence)
			sentence.split(" ").map{|word| word.capitalize}.join(" ")
	end

	class User
		def initialize(name,surname,email,password=SecureRandom.base64(12))
			@owned_groups = Array.new
			super(name.capitalize,WeMeet.capitalize_sentence(surname),email,password)
		end

		def login(suplied_pass)
			self.password == suplied_pass
		end

		def change_pass(new_pass)
			self.password = new_pass
		end

		def create_group(group_name)
			@owned_groups << Group.new(group_name,self)
		end

		def each_owned_group
			@owned_groups.each {|group| yield group}
		end

		def to_s
			"#{name} #{surname}"
		end
	end
end

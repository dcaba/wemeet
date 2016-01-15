module WeMeet
	User = Struct.new(:name,:surname,:email,:password)
	def self.capitalize_sentence(sentence)
			sentence.split(" ").map{|word| word.capitalize}.join(" ")
	end

	class User
		def initialize(name,surname,email,password)
			super(name.capitalize,WeMeet::capitalize_sentence(surname),email,password)
		end
		def login(suplied_pass)
			puts "sup: #{suplied_pass}, ive:#{@password}"
			@password == suplied_pass
		end
		def change_pass(new_pass)
			@password = new_pass
		end
		def to_s
			"#{name} #{surname}"
		end
	end
end

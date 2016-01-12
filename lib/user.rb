module WeMeet
	User = Struct.new(:name,:surname,:email)
	class User
		def initialize(name,surname,email)
			split_cap_surname = surname.split(" ").map{|word| word.capitalize}
			super(name.capitalize, split_cap_surname.join(" "), email)
		end
		def to_s
			"#{name} #{surname}"
		end
	end
end

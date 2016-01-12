require 'user'

module WeMeet 
	describe User do
		before do
			@user = User.new("daniel","caballero rodriguez","dani.caba@gmail.com")
		end
		it "contains its name and surnames capitalized"
		it "prints his complete name as expected"

	end
end

require 'user'

module WeMeet 
	describe User do
		before do
			@user = User.new("daniel","caballero rodriguez","dani.caba@gmail.com")
		end
		it "contains its name and surnames capitalized" do
			expect(@user.name).to be == "Daniel"
			expect(@user.surname).to be == "Caballero Rodriguez"
		end
		it "prints his complete name as expected" do
			expect(@user.to_s).to be == "Daniel Caballero Rodriguez"
		end

	end
end

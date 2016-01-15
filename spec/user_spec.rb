require 'user'

module WeMeet 
	describe User do
		before do
			@pass = "mypassword"
			@user = User.new("daniel","caballero rodriguez","dani.caba@gmail.com",@pass)
		end
		it "contains its name and surnames capitalized" do
			expect(@user.name).to be == "Daniel"
			expect(@user.surname).to be == "Caballero Rodriguez"
		end
		it "prints his complete name as expected" do
			expect(@user.to_s).to be == "Daniel Caballero Rodriguez"
		end
		it "can authenticate" do
			expect(@user.login(@pass)).to be true
		end
		it "can change the password" do
			new_pass="mynewpassword"
			@user.change_pass(new_pass)
			expect(@user.login(@pass)).to be false
			expect(@user.login(new_pass)).to be true
		end

	end
end

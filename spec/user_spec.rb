require 'user'
require 'group'

module WeMeet 
	describe User do
		before do
			@pass = "mypassword"
			@user_email = "dani.caba@gmail.com"
			@user = User.new("daniel","caballero rodriguez",@user_email,@pass)
		end
		it "contains its name and surnames capitalized" do
			expect(@user.name).to be == "Daniel"
			expect(@user.surname).to be == "Caballero Rodriguez"
		end
		it "prints his complete name as expected" do
			expect(@user.to_s).to be == "Daniel Caballero Rodriguez"
		end
		it "keeps the registered email address" do
			expect(@user.email).to be == @user_email
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
		it "can have some activities and time preferences" 
		it "can set some restaurant preferences"
		it "has an agenda"
		it "can set some global dating preferences"
		it "can create groups that will own" do
			@user.create_group("MetalBand members")	
			found = false
			@user.each_owned_group do |group|
				found = true if group.name == "MetalBand members"
			end
			expect(found).to be true
		end
		it "can be part of groups owned by other users" do
			@user2 = User.new("lina","far","lina@mymail.com")
			new_group = @user2.create_group("family")	
			@user2.each_owned_group do |group|
				new_group = group if group.name == "family" 
				new_group.add_member(@user) 
			end
			expect(new_group).to have_as_member @user

		end

	end
end

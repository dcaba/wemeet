require 'group'
require 'user'

module WeMeet 
	describe Group do
		before do
			@group_name = "school friends"
			@owner = User.new("Daniel","Caballero Rodríguez","dani.caba@gmail.com")
			@group = Group.new(@group_name.capitalize, @owner)
		end
		context "being the only member the original owner" do
			it "contains the group name" do
				expect(@group.name).to be == "School friends"
			end

			it "contains an unique email address" do
				expect(@group.mail).to be == "school.friends@wemeet.com"
			end

			it "has the expected owner" do
				expect(@group.owner.name).to be == "Daniel"
			end

			it "contains, at least, the owner" do
				expect(@group.member(@owner)).to be_truth
			end

			it "prints his complete name as expected" do
				expect(@user.to_s).to be == "Daniel Caballero Rodriguez"
			end
			it "can set some restaurant preferences"
			it "has an agenda"
			it "can set some global dating preferences"
		end	
		context "with an additional member" do
		it "can change the ownership to another group member"
		it "can leave"
		end

	end
end

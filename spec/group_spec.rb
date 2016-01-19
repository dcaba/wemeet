require 'group'
require 'user'

module WeMeet 
	describe Group do
		before do
			@group_name = "school friends"
			@owner = User.new("Daniel","Caballero Rodríguez","dani.caba@gmail.com","pass")
			@group = Group.new(@group_name.capitalize, @owner)
		end
		context "containing only the initial owner" do
			it "contains the group name that can be modified" do
				expect(@group.name).to be == "School friends"
				@group.name = "School Friends"
				expect(@group.name).to be == "School Friends"
			end

			it "contains an automatically created & unique email address" do
				expect(@group.email).to be == "school.friends@#{GADDRESS_SUFFIX}"
			end

			it "has the expected owner" do
				expect(@group.owner.email).to be == "dani.caba@gmail.com"
			end

			it "contains, at least, the owner" do
				expect(@group).to have_member @owner
			end

			it "prints his info as expected" do
				expect(@group.to_s).to be == "School friends group managed by Daniel Caballero Rodriguez"
			end
			it "can contain activities and time preferences"
			it "has an agenda"
			it "has a preferred area"
			it "has a default frequency"
			it "has a wall where members can write"
		end	
		context "with an additional member" do
			it "can change the ownership to another group member"
			it "any member can leave"
		end

	end
end

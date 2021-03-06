# encoding: utf-8
require 'we_meet/group'
require 'we_meet/user'
require 'we_meet/message'

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
				expect(@group).to have_as_member @owner
			end

			it "prints his info as expected" do
				expect(@group.to_s).to be == "School friends group managed by Daniel Caballero Rodríguez with 1 members"
			end
			it "can contain activities and time preferences"
			it "has an agenda"
			it "has a preferred area"
			it "has a default frequency"
			it "has a wall where members can send messages" do
				message = Message.new("Hello world!",@owner)
				@group.send_message(message)
				messages = @group.get_messages
				expect(messages.pop).to be == message
			end
			it "the owner, and only member, cannot swap ownership or leave" do
				expect {@group.swap_ownership}.to raise_error(RuntimeError,"Owner is the only member")
			end
		end	
		context "with an additional member" do
			before do
				@user = User.new("Lina","Far","email@email.com")
				@group.add_member(@user)
			end

			it "has the expected two members" do
				expect(@group).to have_as_member @owner
				expect(@group).to have_as_member @user
			end

			it "doesnt have a third member" do
				num_members = 0
				@group.each_member { num_members += 1}
				expect(num_members).to be 2
			end

			it "can change the ownership to another group member" do
				@group.swap_ownership
				expect(@group.owner).to be == @user
			end
			it "any member can leave" do
				@group.leave(@user)
				expect(@group).not_to have_as_member @user
				@group.add_member(@user)
				@group.leave(@owner)
				expect(@group).not_to have_as_member @owner
			end
		end

	end
end

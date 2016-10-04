require 'we_meet/message'
require 'we_meet/user'

module WeMeet
	describe Message do
		context "created by an user" do
			before do
				@before = Time.now
				@user = User.new("Dani","Caba","dani.caba@mymail.com")	
				@after = Time.now
				@message = Message.new("hello world!",@user)
			end
			it "sender is the expected one" do
				expect(@message.creator).to be == @user
			end
			it "provides the date when it was created" do
				expect(@message.date).to be_a_kind_of(Time)
				expect(@message.date.to_i).to be_within(@after.to_i-@before.to_i).of(@before.to_i)
			end
			it "has the expected text" do
				expect(@message.content).to be == "hello world!"
			end
		end
	end
end

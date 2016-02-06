require 'message'
require 'user'

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
				expect(@message.date).to be_within(@after-@before).of(@before)
			end
			it "has the expected text"
		end
	end
end

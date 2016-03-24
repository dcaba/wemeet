require 'activity'
require 'activities'
# implementation ideas: is this just an static and global enum? struct? object type pattern? singleton? 

module WeMeet
	describe Activities do
		context "with no activity included" do
			before do
				@act = Activities.instance
			end
			it "do not contain any activity" do
				expect(@act.size).to be == 0
			end
			it "searches return empty activities" do
				expect(@act.search "foot").to be == []
				expect(@act.search "").to be == []
			end
		end
		context "with a couple of activities" do
			before do
				@activity1 = Activity.new("Football")
				@activity2 = Activity.new("Basketball")
				@act = Activities.instance
				@act << @activity1
				@act << @activity2
			end
			it "support the removal of one activity"
			it "supports the addition of a new activity"
			it "has the expected activites" 
			it "support partial text searches" do
				expect(@act.search("ball").size).to be == 2
			end
		end
	end
end

require 'activity'

module WeMeet
	describe Activity do
		context "new activity" do
			before do
				@activity = Activity.new("Football")
			end
			it "has the expected activity name" do
				expect(@activity.name).to be == "Football"
			end
			it "support partial text searches" do
				expect(@activity).to be_similar_to "footbal"
			end
		end
		context "with aliases"
	end
end

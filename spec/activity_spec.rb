require 'activity'
require 'activity_category'

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
			it "has a nil as category" do
				expect(@activity.category).to be_nil
			end
		end
		context "with aliases" do
			before do
				@activity = Activity.new("Network gaming")
				@activity.alias("Netgaming")
				@activity.alias("LAN parties")
			end
			it "has the expected aliases" do
				expect(@activity.aliases).to include "Netgaming"
				expect(@activity.aliases).to include "LAN parties"
			end
			it "supports partial text searches" do
				expect(@activity).to be_similar_to "gaming"
				expect(@activity).to be_similar_to "LAN"
				expect(@activity).to be_similar_to "network"
				expect(@activity).to be_similar_to "netgaming"
			end
			it "supports comparison also in case the supplied string is a superset" do
				expect(@activity).to be_similar_to "netgaming in DCs"
			end	
		end
		context "with a category" do
			before do
				@activity = Activity.new("Network gaming")
				@category = ActivityCategory.new("Technology")
				@activity.category = @category
			end
			it "has the expected aliases" do
				expect(@activity.category).to be == @category
			end
		end
	end
end

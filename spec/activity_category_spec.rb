require 'activity_category'

module WeMeet
	describe ActivityCategory do
		context "new category" do
			before do
				@category = Activity.new("Sports")
			end
			it "has the expected category name" do
				expect(@category.name).to be == "Sports"
				expect(@category.name).not_to be == "sports"
			end
			it "support partial text searches" do
				expect(@category).to be_similar_to "sPort"
				expect(@category).not_to be_similar_to "Music"
			end
		end
	end
end

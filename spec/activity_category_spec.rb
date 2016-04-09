require 'activity_category'

module WeMeet
	describe ActivityCategory do
		context "new category" do
			before do
				@category = Activity.new("Sports")
			end
			it "has the expected category name" do
				expect(@category.name).to be == "Sports"
			end
			it "support partial text searches" do
				expect(@category).to be_similar_to "sport"
			end
		end
	end
end

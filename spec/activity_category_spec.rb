require 'activity_category'

module WeMeet
	describe ActivityCategory do
		context "new category" do
			before do
				@category = ActivityCategory.new("sports")
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
		context "several categories" do
			before do
				@category = ActivityCategory.new("sports")
				@category2 = ActivityCategory.new("Sports")
				@category3 = ActivityCategory.new("music")
			end
			it "can be compared" do
				expect(@category == @category2).to be true
				expect(@category == @category3).to be false
			end
		end
	end
end

require 'activity'
require 'activities'
require 'activity_category'
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
		context "with an activity, but after cleaning" do
			before do
				@act = Activities.instance
				@act << Activity.new("Football")
			end
			it "do not contain any activity after clean" do
				@act.clean
				expect(@act.size).to be == 0
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
			after do
				@act.clean
			end
			it "support the removal of one activity" do
				@act.remove("Basketball")
				expect(@act.list).to include "Football"
				expect(@act.list).not_to include "Basketball"
				expect(@act.list.size).to be == 1
			end
			it "supports the addition of a new activity" do
				@activity3 = Activity.new("Playing instrument")
				@act << @activity3
				expect(@act.list).to include "Football"
				expect(@act.list).to include "Basketball"
				expect(@act.list).to include "Playing instrument"
				expect(@act.list.size).to be == 3
			end
			it "support partial text searches" do
				expect(@act.search("ball").size).to be == 2
			end
		end
		context "with 4 activities in 2 categories" do
			before do
				@category1 = ActivityCategory.new("Sports")
				@category2 = ActivityCategory.new("Music")
				@activity1 = Activity.new("Football")
				@activity1.alias "Futbol"
				@activity1.category = @category1 
				@activity2 = Activity.new("Basketball",@category1)
				@activity2.alias "Basquet"
				@activity3 = Activity.new("Playing an instrument")
				@activity3.category = @category2
				@activity4 = Activity.new("Live metal concerts",@category2)
				@act = Activities.instance
				@act << @activity1
				@act << @activity2
				@act.register_category @category2
				@act << @activity3
				@act << @activity4
			end
			after do
				@act.clean
			end
			it "can list registered categories" do
				expect(@act.list_categories).to include @category1
				expect(@act.list_categories).to include @category2
			end
			it "can retrieve activities per category"
			it "support partial text searches with category filters"
			it "cannot accept activities clashing with the registered ones"
			# this includes aliases and activity names
			it "cannot accept categories clashing with the registered ones"
			it "accepts additional categories"
			it "associates the right original category in case of partial clashes"
		end
	end
end

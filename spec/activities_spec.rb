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
				expect(@act.search_by_term "foot").to be == []
				expect(@act.search_by_term "").to be == []
			end
		end
		context "with an activity, but after cleaning," do
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
				expect(@act.list).to include @activity1
				expect(@act.list).not_to include @activity2
				expect(@act.list.size).to be == 1
			end
			it "supports the addition of a new activity" do
				@activity3 = Activity.new("Playing instrument")
				@act << @activity3
				expect(@act.list).to include @activity1
				expect(@act.list).to include @activity2
				expect(@act.list).to include @activity3
				expect(@act.list.size).to be == 3
			end
			it "support partial text searches" do
				expect(@act.search_by_term("ball").size).to be == 2
				expect(@act.search_by_term("ball")).to include @activity1
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
				begin
					@act << @activity2
				rescue
				end
				@act.register_category @category2
				begin 
					@act << @activity3
				rescue
				end
				begin 
					@act << @activity4
				rescue
				end

			end
			after do
				@act.clean
			end
			it "can list registered categories" do
				expect(@act.list_categories).to include @category1
				expect(@act.list_categories).to include @category2
				expect(@act.list_categories.size).to be == 2
			end
			it "can retrieve activities per category" do
				expect(@act.list(@category1)).to include @activity1
				expect(@act.list(@category1)).to include @activity2
				expect(@act.list(@category1).size).to be == 2
				expect(@act.list(@category2)).to include @activity3
				expect(@act.list(@category2)).to include @activity4
				expect(@act.list(@category2).size).to be == 2
			end
			it "support partial text searches with category filters" do
				expect(@act.search_by_term("basket",@category1)).not_to include @activity1
				expect(@act.search_by_term("basket",@category1)).to include @activity2
				expect(@act.search_by_term("ball",@category1).size).to be == 2
				expect(@act.search_by_term("ball",@category2).size).to be == 0
			end
			it "support partial text searches without category filters" do
				expect(@act.search_by_term("ball").size).to be == 2
			end
			it "cannot accept activities clashing with the registered ones" do
				@activity5 = Activity.new("futbol",@category1)
				@activity6 = Activity.new("bol",@category1)
				@activity6.alias "futbol"
				@activity7 = Activity.new("basquet",@category1)
				@activity8 = Activity.new("baloncesto",@category1)
				@activity8.alias "basquet"
				expect {@act << @activity5}.to raise_error(RuntimeError,"Activity already exists")
				expect {@act << @activity6}.to raise_error(RuntimeError,"Activity already exists")
				expect {@act << @activity7}.to raise_error(RuntimeError,"Activity already exists")
				expect {@act << @activity8}.to raise_error(RuntimeError,"Activity already exists")
			end

			it "cannot accept categories clashing with the registered ones" do
				new_category = ActivityCategory.new("music")
				expect {@act.register_category new_category}.to raise_error(RuntimeError,"Category already exists")
			end
			it "accepts additional categories" do
				new_category = ActivityCategory.new("bingo")
				@act.register_category(new_category)
				expect(@act.list_categories).to include new_category
				expect(@act.list_categories.size).to be == 3
			end
			it "can remove activities by activity name, keeping aliases updated" do
				@act.remove("football")
				expect(@act.list).not_to include @activity1
				expect(@act.list).to include @activity2
				expect(@act.list.size).to be == 3
				expect(@act.search_by_term("football")).to be == []
				expect(@act.search_by_term("futbol")).to be == []
			end
			it "can remove activities by alias, keeping aliases updated" do
				@act.remove("futbol")
				expect(@act.list).not_to include @activity1
				expect(@act.list).to include @activity2
				expect(@act.list.size).to be == 3
				expect(@act.search_by_term("football")).to be == []
				expect(@act.search_by_term("futbol")).to be == []
			end
			it "can remove categories, only if no activity is associated" do
				category = ActivityCategory.new("sports")
				expect {@act.remove_category category}.to raise_error(RuntimeError,"Category still associated to a registered activity")
				@act.list(category).each {|activity| @act.remove(activity.name)}
			        @act.remove_category category
				expect(@act.list).not_to include category
				expect(@act.list_categories.size).to be == 1
			end
			it "associates the right original category in case of partial clashes"
		end
	end
end

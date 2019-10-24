require './gilded_rose.rb'
require './texttest_fixture.rb'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("fixme", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "fixme"
    end
  end
end


# Item quality is never negative
# All items have a SellIn value which denotes the number of days we have to sell the item
# All items have a Quality value which denotes how valuable the item is
# At the end of each day our system lowers both values for every item
# Item quality is never more than 50
# Sulfuras" never has to be sold or decreases in Quality
# "Aged Brie" increases in quality the older it gets
# "Conjured" items degrade in Quality twice as fast as normal items
# When item sell by date has passed, Quality degrades twice as fast
# "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
# 	Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
# 	Quality drops to 0 after the concert

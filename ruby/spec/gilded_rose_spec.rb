require './gilded_rose.rb'
require './texttest_fixture.rb'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("fixme", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "fixme"
    end

    # "Aged Brie" increases in quality the older it gets
    it "improves Aged Brie quality score by 1" do
      items = [Item.new("Aged Brie", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
    end

    it "decreases quality score by 1 if not Aged Brie" do
      items = [Item.new("Elixir of the Mongoose", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 19
    end

    it "decreases sell_in by 1" do
      items = [Item.new("Elixir of the Mongoose", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
    end

    # Quality increases by 3 when there are 5 days or less until the concert.
    it "improves Back stage quality score by 3 when there are 5 days or less until the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 23
    end

    # Quality increases by 2 when there are 10 days or less until the concert.
    it "improves Back stage quality score by 2 when there are 10 days or less until the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 22
    end

    # Quality increases by 1 when there are 11 days or more until the concert.
    it "improves Back stage quality score by 1 when there are 11 days or more until the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
    end

    # Quality drops to 0 after the concert
    it "Back stage quality score drops to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    # Item quality is never more than 50
    it "Item quality is never more than 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    # Item quality is never negative
    it "quality does not drop below zero" do
      items = [Item.new("Elixir of the Mongoose", 10, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end
end


  # All items have a SellIn value which denotes the number of days we have to sell the item
  # All items have a Quality value which denotes how valuable the item is
  # At the end of each day our system lowers both values for every item
  # Sulfuras" never has to be sold or decreases in Quality
  # "Conjured" items degrade in Quality twice as fast as normal items
  # When item sell by date has passed, Quality degrades twice as fast

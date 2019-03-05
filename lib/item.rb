class Item < ActiveRecord::Base
  belongs_to :room
  belongs_to :player


  sword = Item.create(name: "sword", category: "weapon", in_inventory?: false)
  sheild = Item.create(name: "sheild", category: "weapon", in_inventory?: false)
  gem = Item.create(name: "ruby", category: "enchantment", in_inventory?: false)
  axe = Item.create(name: "axe", category: "weapon", in_inventory?: false)


  def self.generate_item
    self.all.select {|item| item.category == "weapon"}.sample
  end

end

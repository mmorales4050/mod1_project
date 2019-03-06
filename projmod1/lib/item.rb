class Item < ActiveRecord::Base
  belongs_to :player
  belongs_to :room


  def self.generate_item
    #return an item and save it to database
    item_name = ['Sword', 'Dagger', 'Axe']
    generated_item = Item.create(name: item_name.sample,
                                category: 'Weapon',
                                damage: 1)
  end

end

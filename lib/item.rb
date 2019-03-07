class Item < ActiveRecord::Base
  belongs_to :player
  belongs_to :room


  def self.generate_item
    #return an item and save it to database
    weapon_name = ['Sword', 'Dagger', 'Axe']
    if  Item.all.length > 0 && rand(100) > 50
      Item.all.each{ |item|  item.update(damage: item.damage + 1)}
    else
      Item.create(name: weapon_name.sample, category: 'weapon', damage: 1)
    end
  end

end

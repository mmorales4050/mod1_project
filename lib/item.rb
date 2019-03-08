class Item < ActiveRecord::Base
  belongs_to :player
  belongs_to :room

  def self.generate_item
    weapon_name = @@weapon_name
    # Only makes an enchantment 20% of the time GIVEN the player has something in their inventory
    if  Item.all.length > 0 && rand(100) > 80
    # iterates through each item in your inventory and updates their damage value by 1
      Item.all.each{ |item|  item.update(damage: item.damage + 1)}
    else
    # picks a random a weapon_name from the array and creates it in the database with a random damage value between 1-5
      Item.create(name: weapon_name.sample, category: 'weapon', damage: rand(1..5))
    end
  end

  @@weapon_name = [
                  "Arming sword",
                  "Dagger",
                  "Falchion",
                  "Katana",
                  "Knife",
                  "Longsword",
                  "Sabre",
                  "Shortsword",
                  "Ulfberht",
                  "Estoc",
                  "Rapier",
                  "Battle axe",
                  "Club",
                  "Flail",
                  "Mace",
                  "Flanged mace",
                  "Pernach",
                  "Shestophor",
                  "Maul",
                  "Morning star",
                  "Quarterstaff",
                  "War hammer",
                  "Bec de Corbin",
                  "Horseman’s pick",
                  "Bludgeon",
                  "Ahlspiess",
                  "Bardiche",
                  "Bill",
                  "Glaive",
                  "Guisarme",
                  "Halberd",
                  "Lance",
                  "Lochaber Axe",
                  "Lucerne hammer",
                  "Man catcher",
                  "Military fork",
                  "Partisan",
                  "Pike",
                  "Plançon a picot",
                  "Ranseur",
                  "Sovnya",
                  "Spetum",
                  "Swordstaff",
                  "Voulge",
                  "War-scythe",
                  "War hammer",
                  "Bow",
                  "Longbow",
                  "English longbow",
                  "Recurve bow",
                  "Mongol bow",
                  "Crossbow",
                  "Arbalest",
                  "Ballista",
                  "Repeating crossbow",
                  "Sling",
                  "Chakram",
                  "Francisca",
                  "Kunai",
                  "Nzappa zap",
                  "Throwing Spear",
                  "Shuriken",
                  "Throwing knife",
                  "Culverin",
                  "Hand cannon",
                  "Arquebus",
                  "Musket"]

end

class Item < ActiveRecord::Base
  belongs_to :player
  belongs_to :room




  def self.generate_item
    #return an item and save it to database
    weapon_name = [
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

    if  Item.all.length > 0 && rand(100) > 80
      Item.all.each{ |item|  item.update(damage: item.damage + 1)}
    else
      Item.create(name: weapon_name.sample, category: 'weapon', damage: rand(1..5))
    end
  end

end

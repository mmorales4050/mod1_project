class Player < ActiveRecord::Base
  has_many :items
  has_many :rooms, through: :items

  attr_accessor :location

  def inventory_display
    puts "Inventory:"
    puts Item.all.map { |item| item.name }
  end

  def check(direction, char)

  end


  def move(operator, room)
    room.floor[self.location] = " "

    case operator
    when :up
      if room.floor[self.location - (room.width + 1)] == " "
        self.location -= (room.width + 1)
      elsif room.floor[self.location - (room.width + 1)] == "i"
        self.location -= (room.width + 1)
        Item.generate_item
      end

    when :down
      if room.floor[self.location + (room.width + 1)] == " "
        self.location += (room.width + 1)
      end

    when :right
      if room.floor[self.location + 1] == " "
        self.location += 1
      end

    when :left
      if room.floor[self.location - 1] == " "
        self.location -= 1
      end
    end

    room.floor[self.location] = "@"
  end

end

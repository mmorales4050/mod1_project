class Player < ActiveRecord::Base
  has_many :items
  has_many :rooms, through: :items

  attr_accessor :location

  def inventory_display
    inv_list = "Inventory: "
    Item.all.each { |item| inv_list += (item.name + " (damage: #{item.damage}) " + ", ") }
    print inv_list.chomp(", ")
  end


  def check(direction, char, room)
    case direction
      when :up
        room.floor[self.location - (room.width + 1)] == char
      when :down
        room.floor[self.location + (room.width + 1)] == char
      when :right
        room.floor[self.location + 1] == char
      when :left
        room.floor[self.location - 1] == char
    end
  end

  def set(direction, room)
    case direction
      when :up
        self.location -= (room.width + 1)
      when :down
        self.location += (room.width + 1)
      when :right
        self.location += 1
      when :left
        self.location -= 1
    end
  end


  def move(operator, room)
    room.floor[self.location] = " "

    case operator
    when :up
      if check(:up, " ", room)#room.floor[self.location - (room.width + 1)] == " "
        set(:up, room)
      elsif check(:up, "T", room)
        set(:up, room)
        Item.generate_item
      end

    when :down
      if check(:down, " ", room)#room.floor[self.location - (room.width + 1)] == " "
        set(:down, room)
      elsif check(:down, "T", room)
        set(:down, room)
        Item.generate_item
      end

    when :right
      if check(:right, " ", room)#room.floor[self.location - (room.width + 1)] == " "
        set(:right, room)
      elsif check(:right, "T", room)
        set(:right, room)
        Item.generate_item
      end
    when :left
      if check(:left, " ", room)#room.floor[self.location - (room.width + 1)] == " "
        set(:left, room)
      elsif check(:left, "T", room)
        set(:left, room)
        Item.generate_item
      end
    end

    room.floor[self.location] = "@"
  end

end

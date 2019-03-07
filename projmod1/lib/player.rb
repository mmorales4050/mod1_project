class Player < ActiveRecord::Base
  has_many :items
  has_many :rooms, through: :items

  attr_accessor :location

  def inventory_display
    inv_list = "Inventory: "
    Item.all.each { |item| inv_list += (item.name + " ") }
    print inv_list
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


  def move(operator, room, floor)
    room.floor[self.location] = floor
    case operator
    when :up
      if check(:up, floor, room)#room.floor[self.location - (room.width + 1)] == floor
        set(:up, room)
      elsif check(:up, "i", room)
        set(:up, room)
        Item.generate_item
      end

    when :down
      if check(:down, floor, room)#room.floor[self.location - (room.width + 1)] == floor
        set(:down, room)
      elsif check(:down, "i", room)
        set(:down, room)
        Item.generate_item
      end

    when :right
      if check(:right, floor, room)#room.floor[self.location - (room.width + 1)] == floor
        set(:right, room)
      elsif check(:right, "i", room)
        set(:right, room)
        Item.generate_item
      end
    when :left
      if check(:left, floor, room)#room.floor[self.location - (room.width + 1)] == " "
        set(:left, room)
      elsif check(:left, "i", room)
        set(:left, room)
        Item.generate_item
      end
    end
    room.floor[self.location] = "@"
  end

  def move_runner(operator, room, floor)
    room.floor[self.location] = " "
    while self.location !< (room.floor.length) && self.location > 0
      self.location == rand(0..(room.floor.length/2))
    end
      case operator
      when :up
        set(:up, room)
      when :down
        set(:down, room)
      when :right
        set(:right, room)
      when :left
        set(:left, room)
      end
      room.floor[self.location] = " "
    end

  end

end

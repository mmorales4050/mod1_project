require "spec_helper"


describe "Project" do
  #
  # let!(:pluto) { Dog.new("Pluto") }
  # let!(:fido) { Dog.new("Fido") }
  # let!(:maddy) { Dog.new("Maddy") }
  #
  # after(:each) do
  #   Dog.class_variable_set(:@@all, [])
  # end

  describe "The player can move up" do
    it "Moves the player up by one space" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 100
      room.height = 100
      game.spawn_player(room, player)
      start_location = player.location
      player.move(:up, room, " ")
      expect(room.floor[player.location]).to eq(room.floor[start_location - (room.width + 1)])
    end
  end

  describe "The player can move down" do
    it "Moves the player down by one space" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 100
      room.height = 100
      game.spawn_player(room, player)
      start_location = player.location
      player.move(:down, room, " ")
      expect(room.floor[player.location]).to eq(room.floor[start_location + (room.width + 1)])
    end
  end

  describe "The player can move right" do
    it "Moves the player right by one space" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 100
      room.height = 100
      game.spawn_player(room, player)
      start_location = player.location
      player.move(:right, room, " ")
      expect(room.floor[player.location]).to eq(room.floor[start_location + 1])
    end
  end
  describe "The player can move left" do
    it "The player can move left" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 100
      room.height = 100
      game.spawn_player(room, player)
      start_location = player.location
      player.move(:left, room, " ")
      expect(room.floor[player.location]).to eq(room.floor[start_location - 1])
    end
  end
  describe "Item.generate_item" do
    it "Creates an item in the items table" do
      Item.generate_item
      expect(Item.all.length).to eq(1)
      Item.destroy_all
    end
  end
  describe "Player#inventory_display" do
    it "Displays the inventory" do
      Item.generate_item
      player = Player.new
      expect{player.inventory_display}.to output("Inventory: #{Item.all.first.name} ").to_stdout
      Item.destroy_all
    end
  end
  describe "Weapon enchantments" do
    it "Enchantments increase the attack of a weapon" do
      10.times do
        Item.generate_item
      end
      expect(Item.all.first.damage > 1).to eq(true)
      Item.destroy_all
    end
  end

  describe "The player cant move up into a wall" do
    it "Moves the player does not move up when a wall is blocking the way" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 10
      room.height = 10
      game.spawn_player(room, player)
      10.times do
        player.move(:up, room, " ")
      end
      start_location = player.location
      player.move(:up, room, " ")
      expect(room.floor[start_location]).to eq(room.floor[player.location])
    end
  end

  describe "The player cant move down into a wall" do
    it "Moves the player does not move down when a wall is blocking the way" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 10
      room.height = 10
      game.spawn_player(room, player)
      10.times do
        player.move(:down, room, " ")
      end
      start_location = player.location
      player.move(:down, room, " ")
      expect(room.floor[start_location]).to eq(room.floor[player.location])
    end
  end
  describe "The player cant move left into a wall" do
    it "Moves the player does not move left when a wall is blocking the way" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 100
      room.height = 100
      game.spawn_player(room, player)
      100.times do
        player.move(:left, room, " ")
      end
      start_location = player.location
      player.move(:left, room, " ")
      expect(room.floor[start_location]).to eq(room.floor[player.location])
    end
  end
  describe "The player cant move down into a wall" do
    it "Moves the player does not move down when a wall is blocking the way" do
      game = Game.new
      room = Room.new
      player = Player.new
      room.width = 10
      room.height = 10
      game.spawn_player(room, player)
      10.times do
        player.move(:down, room, " ")
      end
      start_location = player.location
      player.move(:down, room, " ")
      expect(room.floor[start_location]).to eq(room.floor[player.location])
    end
  end
end

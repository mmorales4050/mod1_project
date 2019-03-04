
@top_wall = "---------------------"

@side_wall = "|                   |\n"

@space = "                     "

def make_room

  puts @top_wall
  puts @side_wall * 10
  puts @top_wall
end

make_room

user_input = gets.chomp

puts "\e[H\e[2J"

make_room

user_input = gets.chomp

puts "\e[H\e[2J"

make_room

user_input = gets.chomp

puts "\e[H\e[2J"

make_room

user_input = gets.chomp

puts "\e[H\e[2J"

make_room

user_input = gets.chomp

puts "\e[H\e[2J"

make_room

#Test comment

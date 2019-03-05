class Player < ActiveRecord::Base
  has_many :items
  has_many :rooms, through: :items

end

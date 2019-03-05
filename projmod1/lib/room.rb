class Room < ActiveRecord::Base
  has_many :items
  has_many :players, through: :items
end

class Item < ActiveRecord::Base
  belongs_to :player
  belongs_to :room
end

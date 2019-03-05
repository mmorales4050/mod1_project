class CreateItemTable < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.integer :damage
      t.belongs_to :room
      t.integer :player_id
    end
  end
end

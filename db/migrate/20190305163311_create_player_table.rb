class CreatePlayerTable < ActiveRecord::Migration[5.2]
  def change
    create_table :player do |t|
      t.string :item
    end
  end
end

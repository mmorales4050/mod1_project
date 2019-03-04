class CreateItemsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |item|
      item.string :name
      item.string :category
      item.boolean :in_inventory?
    end
  end
end

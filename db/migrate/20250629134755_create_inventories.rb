class CreateInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.integer :quantity
      t.decimal :price
      t.string :location
      t.string :supplier
      t.timestamps
    end
    add_index :inventories, :sku
  end
end

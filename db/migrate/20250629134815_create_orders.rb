class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :customer_name
      t.string :customer_email
      t.string :status
      t.decimal :total_amount
      t.datetime :order_date
      t.datetime :shipped_date
      t.timestamps
    end
    add_index :orders, :order_number
  end
end

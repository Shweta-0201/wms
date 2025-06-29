# Sample seed data for WMS API

# Create sample inventory items
inventories = [
  {
    sku: "LAPTOP001",
    name: "Dell Laptop",
    description: "High-performance business laptop",
    quantity: 50,
    price: 999.99,
    location: "A1-B2",
    supplier: "Dell Inc"
  },
  {
    sku: "MOUSE001",
    name: "Wireless Mouse",
    description: "Ergonomic wireless mouse",
    quantity: 200,
    price: 29.99,
    location: "A2-C1",
    supplier: "Logitech"
  },
  {
    sku: "KEYBOARD001",
    name: "Mechanical Keyboard",
    description: "RGB mechanical gaming keyboard",
    quantity: 75,
    price: 149.99,
    location: "A2-C2",
    supplier: "Corsair"
  },
  {
    sku: "MONITOR001",
    name: "4K Monitor",
    description: "27-inch 4K UHD monitor",
    quantity: 30,
    price: 399.99,
    location: "B1-A1",
    supplier: "Samsung"
  }
]

inventories.each do |inventory_data|
  inventory = Inventory.find_or_create_by(sku: inventory_data[:sku]) do |inv|
    inv.assign_attributes(inventory_data)
  end
  puts "Created/Updated inventory: #{inventory.name} (#{inventory.sku})"
end

# Create sample orders
laptop = Inventory.find_by(sku: "LAPTOP001")
mouse = Inventory.find_by(sku: "MOUSE001")
keyboard = Inventory.find_by(sku: "KEYBOARD001")

if laptop && mouse && keyboard
  order = Order.create!(
    customer_name: "John Doe",
    customer_email: "john.doe@company.com",
    status: "pending",
    total_amount: 1 # Temporary value, will be updated
  )

  # Create order items
  order_items = [
    { inventory: laptop, quantity: 2, unit_price: laptop.price },
    { inventory: mouse, quantity: 5, unit_price: mouse.price },
    { inventory: keyboard, quantity: 1, unit_price: keyboard.price }
  ]

  total = 0
  order_items.each do |item_data|
    order_item = order.order_items.create!(item_data)
    total += order_item.total_price
  end

  order.update!(total_amount: total)
  puts "Created order: #{order.order_number} for #{order.customer_name}"

  # Create another order
  order2 = Order.create!(
    customer_name: "Jane Smith",
    customer_email: "jane.smith@tech.com",
    status: "processing",
    total_amount: 1 # Temporary value, will be updated
  )

  order_item2 = order2.order_items.create!(
    inventory: laptop,
    quantity: 1,
    unit_price: laptop.price
  )

  order2.update!(total_amount: order_item2.total_price)
  puts "Created order: #{order2.order_number} for #{order2.customer_name}"
end

puts "Seed data completed!"
puts "Inventory items: #{Inventory.count}"
puts "Orders: #{Order.count}"
puts "Order items: #{OrderItem.count}"

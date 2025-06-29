# WMS API Testing Guide

## ⚡ Quick Start Commands

After completing the setup, here are the commands you need to run to test the APIs:

### 1. Start the Server
```bash
cd wms_api
rails server -p 3000
```

### 2. Test API Endpoints

#### **Get All Inventory Items**
```bash
curl http://localhost:3000/api/v1/inventories
```

#### **Get All Orders**
```bash
curl http://localhost:3000/api/v1/orders
```

#### **Get Single Inventory Item**
```bash
curl http://localhost:3000/api/v1/inventories/1
```

#### **Create New Inventory Item**
```bash
curl -X POST http://localhost:3000/api/v1/inventories \
  -H "Content-Type: application/json" \
  -d '{
    "inventory": {
      "sku": "PRINTER001",
      "name": "Laser Printer",
      "description": "High-speed laser printer",
      "quantity": 25,
      "price": 299.99,
      "location": "B2-C1",
      "supplier": "HP"
    }
  }'
```

#### **Create New Order with Items**
```bash
curl -X POST http://localhost:3000/api/v1/orders \
  -H "Content-Type: application/json" \
  -d '{
    "order": {
      "customer_name": "Alice Johnson",
      "customer_email": "alice@example.com",
      "status": "pending",
      "total_amount": 1149.98
    },
    "order_items": [
      {
        "inventory_id": 1,
        "quantity": 1,
        "unit_price": 999.99
      },
      {
        "inventory_id": 3,
        "quantity": 1,
        "unit_price": 149.99
      }
    ]
  }'
```

#### **Update Order Status**
```bash
curl -X PUT http://localhost:3000/api/v1/orders/1 \
  -H "Content-Type: application/json" \
  -d '{
    "order": {
      "status": "shipped",
      "shipped_date": "2024-12-30T10:00:00Z"
    }
  }'
```

## 🌐 Viewing APIs on the Web

### Option 1: Browser Testing
You can directly open these URLs in your web browser:

- **All Inventories**: http://localhost:3000/api/v1/inventories
- **All Orders**: http://localhost:3000/api/v1/orders
- **Single Inventory**: http://localhost:3000/api/v1/inventories/1
- **Single Order**: http://localhost:3000/api/v1/orders/1

### Option 2: API Testing Tools

#### **Postman**
1. Download and install Postman
2. Create new requests with:
   - Base URL: `http://localhost:3000/api/v1`
   - Set `Content-Type: application/json` for POST/PUT requests
   - Use the JSON payloads from examples above

#### **VS Code REST Client Extension**
Create a file `api-test.rest` with:
```http
### Get All Inventories
GET http://localhost:3000/api/v1/inventories

### Get All Orders
GET http://localhost:3000/api/v1/orders

### Create Inventory
POST http://localhost:3000/api/v1/inventories
Content-Type: application/json

{
  "inventory": {
    "sku": "WEBCAM001",
    "name": "HD Webcam",
    "description": "1080p HD webcam",
    "quantity": 100,
    "price": 89.99,
    "location": "A3-D1",
    "supplier": "Logitech"
  }
}
```

### Option 3: Simple Web Interface
For a quick visual check, you can create a simple HTML file:

```html
<!DOCTYPE html>
<html>
<head>
    <title>WMS API Test</title>
</head>
<body>
    <h1>WMS API Tester</h1>
    <button onclick="getInventories()">Get Inventories</button>
    <button onclick="getOrders()">Get Orders</button>
    <div id="results"></div>

    <script>
        async function getInventories() {
            const response = await fetch('http://localhost:3000/api/v1/inventories');
            const data = await response.json();
            document.getElementById('results').innerHTML = '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        }

        async function getOrders() {
            const response = await fetch('http://localhost:3000/api/v1/orders');
            const data = await response.json();
            document.getElementById('results').innerHTML = '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        }
    </script>
</body>
</html>
```

## 📊 Database Operations

### Check Database Content
```bash
# Connect to PostgreSQL
psql -U postgres -d wms_api_development

# View tables
\dt

# Check inventory data
SELECT * FROM inventories;

# Check orders data
SELECT * FROM orders;

# Check order items
SELECT * FROM order_items;

# Exit PostgreSQL
\q
```

### Reset Database
```bash
cd wms_api
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

## 🔍 API Endpoints Summary

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/inventories` | List all inventory items |
| GET | `/api/v1/inventories/:id` | Get specific inventory item |
| POST | `/api/v1/inventories` | Create new inventory item |
| PUT | `/api/v1/inventories/:id` | Update inventory item |
| DELETE | `/api/v1/inventories/:id` | Delete inventory item |
| GET | `/api/v1/orders` | List all orders (with items) |
| GET | `/api/v1/orders/:id` | Get specific order |
| POST | `/api/v1/orders` | Create new order with items |
| PUT | `/api/v1/orders/:id` | Update order |
| DELETE | `/api/v1/orders/:id` | Delete order |

## 🚀 Production Deployment

For production deployment:

1. Set environment variables:
```bash
export DATABASE_USERNAME=your_username
export DATABASE_PASSWORD=your_password
export WMS_API_DATABASE_PASSWORD=your_production_password
```

2. Update database.yml for production settings
3. Run migrations: `rails db:migrate RAILS_ENV=production`
4. Start server: `rails server -e production`

## 🛠 Troubleshooting

### Server Won't Start
```bash
# Check if port is in use
lsof -i :3000

# Kill existing Rails processes
pkill -f "rails server"

# Restart PostgreSQL
sudo service postgresql restart
```

### Database Connection Issues
```bash
# Check PostgreSQL status
sudo service postgresql status

# Connect to PostgreSQL as postgres user
sudo -u postgres psql

# Create database manually if needed
sudo -u postgres createdb wms_api_development
```

### Reset Everything
```bash
# Stop server
pkill -f "rails server"

# Reset database
cd wms_api
rails db:drop db:create db:migrate db:seed

# Restart server
rails server -p 3000
```

## 📝 Sample Data

The system comes with pre-loaded sample data:
- 4 inventory items (Laptop, Mouse, Keyboard, Monitor)
- 2 sample orders with multiple items
- Proper relationships between orders and inventory items

This data is perfect for testing all CRUD operations and understanding the system's capabilities.

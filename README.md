# 📦 WMS API - Warehouse Management System

A robust RESTful API for Warehouse Management System built with Ruby on Rails 8, featuring complete CRUD operations for inventory and order management.

## 🚀 Features

- **Inventory Management**: Full CRUD operations for warehouse inventory
- **Order Processing**: Complete order lifecycle management with line items
- **RESTful API Design**: Clean, predictable API endpoints
- **Auto-generated Order Numbers**: Unique order identification system
- **Data Validation**: Comprehensive input validation and error handling
- **PostgreSQL Database**: Production-ready database system
- **API Versioning**: Future-proof API design with versioning

## 🛠️ Technology Stack

- **Backend**: Ruby on Rails 8.0 (API-only)
- **Database**: PostgreSQL 12+
- **Language**: Ruby 3.2.2
- **Testing**: Rails Test Suite

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Ruby 3.2.2 or higher
- Rails 8.0+
- PostgreSQL 12+
- Git

## ⚡ Quick Start

### 1. Clone the Repository
```bash
git clone <repository-url>
cd wms_api
```

### 2. Install Dependencies
```bash
bundle install
```

### 3. Setup Database
```bash
# Create and setup database
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the Server
```bash
rails server -p 3000
```

The API will be available at `http://localhost:3000`

## 📚 API Documentation

### Base URL
```
http://localhost:3000/api/v1
```

### 📦 Inventory Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/inventories` | List all inventory items |
| GET | `/api/v1/inventories/:id` | Get specific inventory item |
| POST | `/api/v1/inventories` | Create new inventory item |
| PUT | `/api/v1/inventories/:id` | Update inventory item |
| DELETE | `/api/v1/inventories/:id` | Delete inventory item |

### 🛒 Order Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/orders` | List all orders (with items) |
| GET | `/api/v1/orders/:id` | Get specific order |
| POST | `/api/v1/orders` | Create new order with items |
| PUT | `/api/v1/orders/:id` | Update order |
| DELETE | `/api/v1/orders/:id` | Delete order |

### 🧪 Quick API Test

```bash
# Get all inventories
curl http://localhost:3000/api/v1/inventories

# Get all orders
curl http://localhost:3000/api/v1/orders

# Create new inventory item
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

# Create new order with items
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
      }
    ]
  }'
```

## 🗂️ Project Structure

```
wms_api/
├── app/
│   ├── controllers/api/v1/          # API Controllers
│   │   ├── inventories_controller.rb
│   │   └── orders_controller.rb
│   └── models/                      # Data Models
│       ├── inventory.rb
│       ├── order.rb
│       └── order_item.rb
├── config/
│   ├── routes.rb                    # API Routes
│   └── database.yml                 # Database Configuration
├── db/
│   ├── migrate/                     # Database Migrations
│   ├── seeds.rb                     # Sample Data
│   └── schema.rb                    # Database Schema
├── test/                            # Test Suite
│   ├── controllers/api/v1/          # Controller Tests
│   └── models/                      # Model Tests
├── API_EXAMPLES.md                  # Detailed API Examples
├── ARCHITECTURE.md                  # Architecture Decisions
├── TESTING_GUIDE.md                 # Testing Instructions
└── README.md                        # This file
```

## 💾 Database Schema

### Core Tables

#### `inventories`
- **Purpose**: Store product/inventory information
- **Key Fields**: `sku` (unique), `name`, `quantity`, `price`, `location`
- **Relationships**: Has many `order_items`

#### `orders`
- **Purpose**: Store customer orders
- **Key Fields**: `order_number` (auto-generated), `customer_name`, `status`, `total_amount`
- **Relationships**: Has many `order_items`

#### `order_items`
- **Purpose**: Junction table linking orders to inventory items
- **Key Fields**: `order_id`, `inventory_id`, `quantity`, `unit_price`, `total_price`
- **Relationships**: Belongs to `orders` and `inventories`

## 🧪 Testing

Run the test suite:

```bash
# Run all tests
rails test

# Run specific test files
rails test test/models/inventory_test.rb
rails test test/controllers/api/v1/inventories_controller_test.rb

# Run tests with coverage
rails test --verbose
```

## 🔧 Development

### Database Operations

```bash
# Reset database
rails db:drop db:create db:migrate db:seed

# Check database
psql -U postgres -d wms_api_development

# Create new migration
rails generate migration AddColumnToTable column:type

# Create new model
rails generate model ModelName field:type
```


## 🌐 Environment Configuration

### Development
```bash
# Default configuration in config/database.yml
# PostgreSQL with local connection
```

### Production
Set the following environment variables:
```bash
export DATABASE_USERNAME=your_username
export DATABASE_PASSWORD=your_password
export WMS_API_DATABASE_PASSWORD=your_production_password
export RAILS_ENV=production
```


Access sample data by visiting the API endpoints after running `rails db:seed`.

## 🔍 API Response Examples

### Successful Response
```json
{
  "id": 1,
  "sku": "LAPTOP001",
  "name": "Dell Laptop",
  "description": "High-performance laptop",
  "quantity": 50,
  "price": "999.99",
  "location": "A1-B2",
  "supplier": "Dell Inc",
  "created_at": "2024-01-01T10:00:00Z",
  "updated_at": "2024-01-01T10:00:00Z"
}
```

### Error Response
```json
{
  "errors": {
    "sku": ["can't be blank"],
    "name": ["can't be blank"],
    "quantity": ["must be greater than or equal to 0"]
  }
}
```


```

## 📞 Support

For support and questions:
- Check the [TESTING_GUIDE.md](TESTING_GUIDE.md) for detailed usage instructions
- Review [API_EXAMPLES.md](API_EXAMPLES.md) for complete API documentation
- Read [ARCHITECTURE.md](ARCHITECTURE.md) for technical decisions and design patterns


---

**Built with ❤️ using Ruby on Rails 8**

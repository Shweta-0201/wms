# WMS API Examples

## Base URL
```
http://localhost:3000/api/v1
```

## Inventory Endpoints

### 1. Get All Inventories
```bash
curl -X GET http://localhost:3000/api/v1/inventories
```

**Response:**
```json
[
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
]
```

### 2. Get Single Inventory
```bash
curl -X GET http://localhost:3000/api/v1/inventories/1
```

### 3. Create Inventory
```bash
curl -X POST http://localhost:3000/api/v1/inventories \
  -H "Content-Type: application/json" \
  -d '{
    "inventory": {
      "sku": "LAPTOP001",
      "name": "Dell Laptop",
      "description": "High-performance laptop",
      "quantity": 50,
      "price": 999.99,
      "location": "A1-B2",
      "supplier": "Dell Inc"
    }
  }'
```

**Response:**
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

### 4. Update Inventory
```bash
curl -X PUT http://localhost:3000/api/v1/inventories/1 \
  -H "Content-Type: application/json" \
  -d '{
    "inventory": {
      "quantity": 45,
      "price": 949.99
    }
  }'
```

### 5. Delete Inventory
```bash
curl -X DELETE http://localhost:3000/api/v1/inventories/1
```

## Order Endpoints

### 1. Get All Orders
```bash
curl -X GET http://localhost:3000/api/v1/orders
```

**Response:**
```json
[
  {
    "id": 1,
    "order_number": "WMS-20240101-A1B2C3D4",
    "customer_name": "John Doe",
    "customer_email": "john@example.com",
    "status": "pending",
    "total_amount": "1999.98",
    "order_date": "2024-01-01T10:00:00Z",
    "shipped_date": null,
    "created_at": "2024-01-01T10:00:00Z",
    "updated_at": "2024-01-01T10:00:00Z",
    "order_items": [
      {
        "id": 1,
        "order_id": 1,
        "inventory_id": 1,
        "quantity": 2,
        "unit_price": "999.99",
        "total_price": "1999.98"
      }
    ],
    "inventories": [
      {
        "id": 1,
        "sku": "LAPTOP001",
        "name": "Dell Laptop"
      }
    ]
  }
]
```

### 2. Get Single Order
```bash
curl -X GET http://localhost:3000/api/v1/orders/1
```

### 3. Create Order
```bash
curl -X POST http://localhost:3000/api/v1/orders \
  -H "Content-Type: application/json" \
  -d '{
    "order": {
      "customer_name": "John Doe",
      "customer_email": "john@example.com",
      "status": "pending",
      "total_amount": 1999.98
    },
    "order_items": [
      {
        "inventory_id": 1,
        "quantity": 2,
        "unit_price": 999.99
      }
    ]
  }'
```

**Response:**
```json
{
  "id": 1,
  "order_number": "WMS-20240101-A1B2C3D4",
  "customer_name": "John Doe",
  "customer_email": "john@example.com",
  "status": "pending",
  "total_amount": "1999.98",
  "order_date": "2024-01-01T10:00:00Z",
  "shipped_date": null,
  "created_at": "2024-01-01T10:00:00Z",
  "updated_at": "2024-01-01T10:00:00Z",
  "order_items": [
    {
      "id": 1,
      "order_id": 1,
      "inventory_id": 1,
      "quantity": 2,
      "unit_price": "999.99",
      "total_price": "1999.98"
    }
  ],
  "inventories": [
    {
      "id": 1,
      "sku": "LAPTOP001",
      "name": "Dell Laptop"
    }
  ]
}
```

### 4. Update Order Status
```bash
curl -X PUT http://localhost:3000/api/v1/orders/1 \
  -H "Content-Type: application/json" \
  -d '{
    "order": {
      "status": "shipped",
      "shipped_date": "2024-01-02T10:00:00Z"
    }
  }'
```

### 5. Delete Order
```bash
curl -X DELETE http://localhost:3000/api/v1/orders/1
```

## Error Responses

### Validation Error
```json
{
  "errors": {
    "sku": ["can't be blank"],
    "name": ["can't be blank"],
    "quantity": ["must be greater than or equal to 0"]
  }
}
```

### Not Found Error
```json
{
  "error": "Inventory not found"
}
```

## Status Codes
- `200 OK` - Successful GET/PUT requests
- `201 Created` - Successful POST requests
- `204 No Content` - Successful DELETE requests
- `404 Not Found` - Resource not found
- `422 Unprocessable Entity` - Validation errors

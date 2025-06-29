# WMS API Architecture Decisions

## Overview
This is a basic Warehouse Management System (WMS) API built with Ruby on Rails 8, focusing on inventory and order management with RESTful CRUD operations.

## Technology Stack

### Framework & Language
- **Ruby on Rails 8.0** (API-only mode)
- **Ruby 3.2.2**
- **PostgreSQL** (Development database)

### Architecture Decisions

#### 1. API-Only Rails Application
**Decision**: Used `rails new --api` flag to create a lean API-only application
**Rationale**: 
- No need for views, assets, or frontend features
- Reduces overhead and improves performance
- Clear separation of concerns for backend services

#### 2. RESTful API Design
**Decision**: Implemented standard REST endpoints with proper HTTP verbs
**Rationale**:
- Industry standard approach
- Predictable URL patterns
- Easy to integrate with frontend applications
- Clear semantic meaning for each operation

#### 3. Database Choice
**Decision**: PostgreSQL for all environments
**Rationale**:
- Production-ready database system
- ACID compliance and reliability
- Better performance for concurrent operations
- Rich data types and advanced features
- Industry standard for Rails applications

#### 4. API Versioning
**Decision**: Implemented API versioning with `/api/v1/` namespace
**Rationale**:
- Future-proofs the API for breaking changes
- Allows multiple versions to coexist
- Industry best practice

#### 5. Model Relationships
**Decision**: Used proper ActiveRecord associations
- `Inventory` has_many `OrderItems`
- `Order` has_many `OrderItems` 
- `OrderItem` belongs_to both `Inventory` and `Order`

**Rationale**:
- Normalized database design
- Maintains referential integrity
- Supports complex order scenarios

#### 6. Data Validation
**Decision**: Implemented comprehensive model validations
**Rationale**:
- Data integrity at the model level
- Consistent error handling
- Prevents invalid data entry

#### 7. Error Handling
**Decision**: Standardized JSON error responses
**Rationale**:
- Consistent API contract
- Machine-readable error messages
- HTTP status codes follow standards

#### 8. Auto-generated Fields
**Decision**: Auto-generate order numbers and set default dates
**Rationale**:
- Reduces client-side complexity
- Ensures unique identifiers
- Better user experience

## API Endpoints

### Inventory Management
- `GET /api/v1/inventories` - List all inventory items
- `GET /api/v1/inventories/:id` - Get specific inventory item
- `POST /api/v1/inventories` - Create new inventory item
- `PUT /api/v1/inventories/:id` - Update inventory item
- `DELETE /api/v1/inventories/:id` - Delete inventory item

### Order Management
- `GET /api/v1/orders` - List all orders (includes order items and inventory details)
- `GET /api/v1/orders/:id` - Get specific order
- `POST /api/v1/orders` - Create new order with order items
- `PUT /api/v1/orders/:id` - Update order
- `DELETE /api/v1/orders/:id` - Delete order

## Data Models

### Inventory
```ruby
- sku (string, unique, indexed)
- name (string, required)
- description (text)
- quantity (integer, >= 0)
- price (decimal, > 0)
- location (string, required)
- supplier (string)
- timestamps
```

### Order
```ruby
- order_number (string, unique, auto-generated, indexed)
- customer_name (string, required)
- customer_email (string, required, email format)
- status (enum: pending, processing, shipped, delivered, cancelled)
- total_amount (decimal, > 0)
- order_date (datetime, auto-set)
- shipped_date (datetime, optional)
- timestamps
```

### OrderItem
```ruby
- order_id (foreign key)
- inventory_id (foreign key)
- quantity (integer, > 0)
- unit_price (decimal, > 0)
- total_price (decimal, auto-calculated)
- timestamps
```

## Security Considerations
- Input validation and sanitization
- SQL injection prevention (via ActiveRecord)
- Parameter filtering for mass assignment protection
- Error messages don't expose sensitive information

## Scalability Considerations
- Database indexes on frequently queried fields (SKU, order_number)
- Eager loading to prevent N+1 queries
- API versioning for backward compatibility
- Modular controller structure

## Testing Strategy
- Model validations and associations
- Controller CRUD operations
- API endpoint functionality
- Error handling scenarios

## Deployment Considerations
- Environment-specific configurations
- Database migrations
- API documentation
- Health check endpoints (`/up`)

## Future Enhancements
- Authentication and authorization
- Inventory tracking (stock movements)
- Order fulfillment workflow
- Batch operations
- Real-time notifications
- Advanced search and filtering
- Pagination for large datasets
- Rate limiting
- API documentation with Swagger/OpenAPI

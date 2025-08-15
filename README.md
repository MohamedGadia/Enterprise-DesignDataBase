# Enterprise PostgreSQL Database Schema

This project provides a **modular, enterprise-grade PostgreSQL database design** for multi-tenant SaaS platforms.  
It uses a schema-per-domain approach to ensure **scalability**, **maintainability**, and **clear separation of concerns**.

---

## 📂 Schemas & Responsibilities

### 1. **auth**
Authentication, authorization, and user session management.
- `users` – User accounts and metadata.
- `roles` – System roles.
- `user_roles` – Mapping between users and roles.
- `sessions` – Active login sessions.

### 2. **platform**
Core platform-level entities.
- `tenants` – Multi-tenant setup.
- `regions` – Geographic region definitions.
- `audit_logs` – Action and change tracking.
- `attachments` – File references and metadata.

### 3. **catalog**
Product-related data.
- `categories` – Hierarchical product categories.
- `brands` – Product brands.
- `products` – Product details with attributes in JSONB.
- `inventory` – Stock tracking by product/location.

### 4. **crm**
Customer relationship management.
- `customers` – Customer profiles.
- `leads` – Lead tracking and assignment.
- `interactions` – Communication history with customers.

### 5. **sales**
Order processing and fulfillment.
- `orders` – Orders and statuses.
- `order_items` – Products within orders.
- `payments` – Payment transactions.
- `shipments` – Shipping and delivery tracking.

### 6. **finance**
Billing and financial records.
- `invoices` – Billing invoices.
- `transactions` – Credits and debits.

### 7. **hr**
Human resources management.
- `employees` – Employee records.
- `payroll` – Salary and deductions.

---

## 🛠️ Key Features
- **UUIDs** for global uniqueness.
- **ENUM types** for controlled statuses.
- **JSONB** for flexible attributes.
- **Multi-tenancy support** via `tenant_id`.
- **Self-referencing FKs** for hierarchies.
- **Triggers** for sequential order numbers.
- **Indexes** for text search and performance.

---

## 📊 Entity Relationship Diagram (ERD)

![Enterprise DB Schema](https://github.com/MohamedGadia/Enterprise-DesignDataBase/blob/main/ERD_Image/enterprise_postgresql_erd_detailed.png?raw=true)

---
## Programmer
**Mohamed Ahmed Gadia**  
Email: [mohamedgadia00@gmail.com]  
LinkedIn: [Mohamed Gadia](https://www.linkedin.com/in/mohamedgadia) 

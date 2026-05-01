# Data Catalog – Gold Layer

## Overview
The **Gold Layer** represents the business-level data, structured for analytics and reporting.  
It contains **dimension tables** and **fact tables** designed for business insights.

---

## 1. gold.dim_customers

**Purpose:**  
Stores customer details enriched with demographic and geographic data.

### Columns

| Column Name      | Data Type      | Description |
|------------------|----------------|-------------|
| customer_key     | INT           | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id      | INT           | Unique numerical identifier assigned to each customer. |
| customer_number  | NVARCHAR(50)  | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name       | NVARCHAR(50)  | The customer's first name. |
| last_name        | NVARCHAR(50)  | The customer's last name or family name. |
| country          | NVARCHAR(50)  | Country of residence (e.g., 'Australia'). |
| marital_status   | NVARCHAR(50)  | Marital status (e.g., 'Married', 'Single'). |
| gender           | NVARCHAR(50)  | Gender (e.g., 'Male', 'Female', 'N/A'). |
| birthdate        | DATE          | Date of birth (YYYY-MM-DD). |
| create_date      | DATE          | Date when the customer record was created. |

---

## 2. gold.dim_products

**Purpose:**  
Provides detailed information about products and their attributes.

### Columns

| Column Name            | Data Type      | Description |
|------------------------|---------------|-------------|
| product_key            | INT           | Surrogate key uniquely identifying each product record. |
| product_id             | INT           | Internal unique identifier for the product. |
| product_number         | NVARCHAR(50)  | Alphanumeric product code used for tracking or categorization. |
| product_name           | NVARCHAR(50)  | Descriptive product name (type, color, size, etc.). |
| category_id            | NVARCHAR(50)  | Identifier for the product category. |
| category               | NVARCHAR(50)  | High-level classification (e.g., Bikes, Components). |
| subcategory            | NVARCHAR(50)  | Detailed classification within the category. |
| maintenance            | NVARCHAR(50)  | Indicates if maintenance is required ('Yes', 'No'). |
| cost                   | INT           | Base cost of the product. |
| product_line           | NVARCHAR(50)  | Product line or series (e.g., Road, Mountain). |
| start_date             | DATE          | Date when the product became available. |

---

## 3. gold.fact_sales

**Purpose:**  
Stores transactional sales data for analytical use.

### Columns

| Column Name    | Data Type      | Description |
|----------------|---------------|-------------|
| order_number   | NVARCHAR(50)  | Unique identifier for each sales order (e.g., 'SO54496'). |
| product_key    | INT           | Surrogate key linking to `dim_products`. |
| customer_key   | INT           | Surrogate key linking to `dim_customers`. |
| order_date     | DATE          | Date when the order was placed. |
| shipping_date  | DATE          | Date when the order was shipped. |
| due_date       | DATE          | Payment due date. |
| sales_amount   | INT           | Total value of the sale. |
| quantity       | INT           | Number of units ordered. |
| price          | INT           | Price per unit. |

---

## Relationships

- `gold.fact_sales.product_key` → `gold.dim_products.product_key`
- `gold.fact_sales.customer_key` → `gold.dim_customers.customer_key`


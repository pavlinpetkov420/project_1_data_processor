-- Create schema for products domain
CREATE SCHEMA IF NOT EXISTS products AUTHORIZATION p1dp_ora_dba;

SET search_path TO public, employees, vendors, customers, orders, deliveries, products;

SHOW search_path;

-- Products table
CREATE TABLE products.products (
    product_id uuid DEFAULT gen_random_uuid()
    , product_name VARCHAR(100) NOT NULL
    , short_description VARCHAR(50) NOT NULL
    , long_description VARCHAR(500) NOT NULL
    , price_id uuid -- FK
    , category_id uuid --FK
    , subcategory_id uuid --FK
    , vendor_id uuid -- FK
    , is_available BOOLEAN DEFAULT 1 -- Need to dynamically change this column if stock_quantity is 0
    , stock_quantuty INTEGER DEFAULT 0 NOT NULL 
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
);

--  product_prices
CREATE TABLE products.product_prices(
    price_id uuid DEFAULT gen_random_uuid() 
    , product_id uuid --FK
    , vendor_id uuid -- FK
    , base_price DECIMAL(19,2) NOT NULL -- Deliveri Price of Product
    , sell_price DECIMAL(19,2) NOT NULL -- End Customer Sell Price
    , is_sell_price_active BOOLEAN DEFAULT TRUE
    , discount_price DECIMAL(19,2) DEFAULT 0-- Is discount is available
    , is_discount_price_active BOOLEAN DEFAULT FALSE
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
);

-- PRODUCT_CATEGORIES
CREATE TABLE products.product_categories(
    category_id uuid DEFAULT gen_random_uuid()
    , category_name VARCHAR(100) NOT NULL
    , category_description VARCHAR(200) NULL
    , is_active BOOLEAN DEFAULT TRUE
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
);

CREATE TABLE products.product_subcategories(
    subcategory_id uuid DEFAULT gen_random_uuid()
    , category_id uuid -- FK
    , subcategory_name VARCHAR(100) NOT NULL
    , subcategory_description VARCHAR(200) NOT NULL
    , is_active BOOLEAN DEFAULT TRUE
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
);

/*
TODOs: 1 - Done, 2 - DONE, 3 - TODO
- How to connect vendors with products?
    - Through products.products and products.product_prices
    - Reason is we can easily understand which vendor deliver us a product and at what price
- To create an order_details table 
- Create ALL constraints for this domain!
*/
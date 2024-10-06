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
    , is_available BOOLEAN DEFAULT FALSE -- Need to dynamically change this column if stock_quantity is 0
    , stock_quantuty INTEGER DEFAULT 0 NOT NULL 
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
);

ALTER TABLE products.products 
    ADD CONSTRAINT pk_products
        PRIMARY KEY (product_id);

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

-- All PKs


ALTER TABLE products.products 
    ADD CONSTRAINT pk_products
        PRIMARY KEY (product_id);

ALTER TABLE products.product_prices 
    ADD CONSTRAINT pk_product_prices
        PRIMARY KEY (price_id);

ALTER TABLE products.product_categories 
    ADD CONSTRAINT pk_product_categories
        PRIMARY KEY (category_id);

ALTER TABLE products.product_subcategories 
    ADD CONSTRAINT pk_product_subcategories
        PRIMARY KEY (subcategory_id);

-- products.products FK

ALTER TABLE products.products 
    ADD CONSTRAINT fk_products_prices
        FOREIGN KEY (price_id)
        REFERENCES products.product_prices(price_id);

ALTER TABLE products.products
    ADD CONSTRAINT fk_products_categories
        FOREIGN KEY (category_id)
        REFERENCES products.product_categories(category_id);

ALTER TABLE products.products
    ADD CONSTRAINT fk_products_subcategories
        FOREIGN KEY (subcategory_id)
        REFERENCES products.product_subcategories(subcategory_id);

ALTER TABLE products.products
    ADD CONSTRAINT fk_products_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors.vendor(vendor_id);

-- products.product_prices FKs

ALTER TABLE products.product_prices
    ADD CONSTRAINT fk_product_prices_products
        FOREIGN KEY (product_id)
        REFERENCES products.products(product_id);

ALTER TABLE products.product_prices
    ADD CONSTRAINT fk_product_prices_vendors
        FOREIGN KEY (vendor_id)
        REFERENCES vendors.vendor(vendor_id);

-- products.product_subcategories

ALTER TABLE products.product_subcategories
    ADD CONSTRAINT fk_categories_subcategories
        FOREIGN KEY (category_id)
        REFERENCES products.product_categories(category_id);

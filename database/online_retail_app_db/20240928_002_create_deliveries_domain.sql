-- Create schema for deliveries
CREATE SCHEMA IF NOT EXISTS deliveries AUTHORIZATION p1dp_ora_dba;

SET search_path TO public, employees, vendors, customers, orders, deliveries;

-- Link table between orders.orders and deliveries.deliveries
CREATE TABLE deliveries.orders_deliveries(
    order_id uuid NOT NULL,                             -- ID of order UQ
    delivery_id uuid,                                   -- ID of delivery
    created_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of order creation
    created_by VARCHAR(50),                             -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of last update
    updated_by VARCHAR(50),                             -- Identifier of who last updated the record
    CONSTRAINT pk_orders_deliveries PRIMARY KEY (order_id, delivery_id)
);

CREATE TABLE deliveries.delivery_status(
    delivery_status_id SERIAL PRIMARY KEY,              -- PK
    status_description VARCHAR(100) NOT NULL,           -- Description of delivery status
    created_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of order creation
    created_by VARCHAR(50),                             -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of last update
    updated_by VARCHAR(50),
);

CREATE TABLE deliveries.delivery(
    delivery_id uuid DEFAULT gen_random_uuid(),         -- PK
    vendor_id uuid,                                     -- FK vendors.vendor Relation to Delivery vendor
    customer_address_id uuid,                           -- FK customers.delivery_addresses
    delivery_status_id INT NOT NULL,                    -- FK deliveries.delivery_status.delivery_status_id 
    created_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of order creation
    created_by VARCHAR(50),                             -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of last update
    updated_by VARCHAR(50)                              -- Identifier of who last updated the record
);

ALTER TABLE deliveries.delivery_status
    ADD CONSTRAINT  pk_delivery_status
        PRIMARY KEY (delivery_status_id);

ALTER TABLE deliveries.delivery
    ADD CONSTRAINT pk_deliveries
        PRIMARY KEY (delivery_id);

ALTER TABLE deliveries.delivery
    ADD CONSTRAINT fk_orders_deliveries_1
        FOREIGN KEY (delivery_id)
        REFERENCES deliveries.orders_deliveries(delivery_id);

ALTER TABLE deliveries.orders_deliveries
    ADD CONSTRAINT fk_orders_deliveries_2
        FOREIGN KEY (order_id)
        REFERENCES orders.order(order_id);
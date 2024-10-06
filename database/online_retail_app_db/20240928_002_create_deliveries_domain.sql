-- Create schema for deliveries
CREATE SCHEMA IF NOT EXISTS deliveries AUTHORIZATION p1dp_ora_dba;

SET search_path TO public, employees, vendors, customers, orders, deliveries;

SHOW search_path;

-- Link table between orders.orders and deliveries.deliveries
CREATE TABLE deliveries.orders_deliveries(
    order_id UUID NOT NULL,                             -- ID of order PK
    delivery_id UUID DEFAULT gen_random_uuid(),         -- ID of delivery PK
    created_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of record creation
    created_by VARCHAR(50),                             -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of last update
    updated_by VARCHAR(50),                             -- Identifier of who last updated the record
    CONSTRAINT pk_orders_deliveries PRIMARY KEY (order_id, delivery_id)
);

-- Delivery status tracking
CREATE TABLE deliveries.delivery_status(
    delivery_status_id SERIAL PRIMARY KEY,              -- PK
    status_description VARCHAR(100) NOT NULL,           -- Description of delivery status (e.g., In Transit, Delivered)
    created_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of status creation
    created_by VARCHAR(50),                             -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of last update
    updated_by VARCHAR(50)                              -- Identifier of who last updated the record
);

-- Deliveries Table
CREATE TABLE deliveries.delivery(
    delivery_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,  -- PK
    vendor_id UUID,                                          -- FK to vendors.vendor
    customer_address_id UUID,                                -- FK to customers.delivery_addresses
    delivery_status_id INT NOT NULL,                         -- FK to deliveries.delivery_status.delivery_status_id 
    created_at TIMESTAMP DEFAULT clock_timestamp(),          -- Timestamp of delivery creation
    created_by VARCHAR(50),                                  -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),          -- Timestamp of last update
    updated_by VARCHAR(50)                                   -- Identifier of who last updated the record
);

-- Delivery Log (Track various stages of delivery)
CREATE TABLE deliveries.delivery_log(
    delivery_log_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,  -- PK
    delivery_id UUID NOT NULL,                                   -- FK to deliveries.delivery
    delivery_status_id INT NOT NULL,                             -- FK to deliveries.delivery_status
    status_change_date TIMESTAMP DEFAULT clock_timestamp(),      -- Timestamp when the status changed
    created_at TIMESTAMP DEFAULT clock_timestamp(),              -- Timestamp of record creation
    created_by VARCHAR(50)                                       -- Identifier of who created the record
);

-- Add constraints
ALTER TABLE deliveries.delivery
    ADD CONSTRAINT fk_delivery_vendor
    FOREIGN KEY (vendor_id)
    REFERENCES vendors.vendor(vendor_id);

ALTER TABLE deliveries.delivery
    ADD CONSTRAINT fk_delivery_address
    FOREIGN KEY (customer_address_id)
    REFERENCES customers.delivery_addresses(delivery_address_id);

ALTER TABLE deliveries.delivery
    ADD CONSTRAINT fk_delivery_status
    FOREIGN KEY (delivery_status_id)
    REFERENCES deliveries.delivery_status(delivery_status_id);

ALTER TABLE deliveries.delivery_log
    ADD CONSTRAINT fk_delivery_log_delivery
    FOREIGN KEY (delivery_id)
    REFERENCES deliveries.delivery(delivery_id);

ALTER TABLE deliveries.delivery_log
    ADD CONSTRAINT fk_delivery_log_status
    FOREIGN KEY (delivery_status_id)
    REFERENCES deliveries.delivery_status(delivery_status_id);

ALTER TABLE deliveries.orders_deliveries
    ADD CONSTRAINT fk_orders_deliveries_order
    FOREIGN KEY (order_id)
    REFERENCES orders.orders(order_id);

ALTER TABLE deliveries.orders_deliveries
    ADD CONSTRAINT fk_orders_deliveries_delivery
    FOREIGN KEY (delivery_id)
    REFERENCES deliveries.delivery(delivery_id);

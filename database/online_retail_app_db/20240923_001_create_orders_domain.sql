/*
See database\online_retail_app_db\20240928_001_update_orders_domain.sql
for latest updates over orders domain.
Changes were required in order to develop step 4 and beyond of documentation\BusinessProblem.md
*/

-- Create schema for orders
CREATE SCHEMA IF NOT EXISTS orders AUTHORIZATION p1dp_ora_dba;

SET search_path TO public, employees, vendors, customers, orders;

-- Payment Mapping Table: Stores payment methods and statuses
CREATE TABLE orders.payment_mapping (
    payment_id SERIAL PRIMARY KEY,          -- Unique ID for each payment method
    payment_method VARCHAR(100) NOT NULL,   -- Payment method description (e.g., Credit Card, PayPal)
    payment_status VARCHAR(50) NOT NULL,    -- Status of payment (e.g., Pending, Completed, Failed)
    UNIQUE(payment_method, payment_status)  -- Unique combination of method and status
);

-- Order Status Mapping: Stores various statuses for orders
CREATE TABLE orders.order_status_mapping (
    status_id SERIAL PRIMARY KEY,            -- Unique ID for order status
    status_description VARCHAR(100) NOT NULL -- Description of order status (e.g., Shipped, Delivered, Cancelled)
);

-- Orders Table: Stores order information for each customer
-- Fix for this table is added on a separate script
-- Adding relation between orders.orders and customers.delivery_addresses 
CREATE TABLE orders.orders (
    order_id UUID DEFAULT gen_random_uuid() PRIMARY KEY, -- Unique identifier for each order
    customer_id UUID NOT NULL,                          -- Links to the customers table
    order_date TIMESTAMP DEFAULT clock_timestamp() NOT NULL, -- Date when the order was placed
    total_amount DECIMAL(10, 2) NOT NULL,               -- Total amount of the order
    status_id INT,                                      -- FK to order_status_mapping table
    payment_id INT,                                     -- FK to payment_mapping table
    created_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of order creation
    created_by VARCHAR(50),                             -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),     -- Timestamp of last update
    updated_by VARCHAR(50),                             -- Identifier of who last updated the record
    CONSTRAINT fk_orders_status FOREIGN KEY (status_id) REFERENCES orders.order_status_mapping(status_id),
    CONSTRAINT fk_orders_payment FOREIGN KEY (payment_id) REFERENCES orders.payment_mapping(payment_id)
);

-- Payments Table: Stores payment information for each order
CREATE TABLE orders.payments (
    payment_transaction_id UUID DEFAULT gen_random_uuid() PRIMARY KEY, -- Unique identifier for payment transaction
    order_id UUID NOT NULL,                                          -- FK to orders table
    payment_id INT NOT NULL,                                         -- FK to payment_mapping table
    payment_date TIMESTAMP DEFAULT clock_timestamp() NOT NULL,       -- Date when payment was made
    amount DECIMAL(10, 2) NOT NULL,                                  -- Payment amount
    created_at TIMESTAMP DEFAULT clock_timestamp(),                  -- Timestamp of payment creation
    created_by VARCHAR(50),                                          -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),                  -- Timestamp of last update
    updated_by VARCHAR(50),                                          -- Identifier of who last updated the record
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders.orders(order_id),
    CONSTRAINT fk_payments_payment FOREIGN KEY (payment_id) REFERENCES orders.payment_mapping(payment_id)
);

-- Refund Status Mapping Table: Stores various statuses for refunds
CREATE TABLE orders.refund_status_mapping (
    refund_status_id SERIAL PRIMARY KEY,           -- Unique ID for each refund status
    refund_status_description VARCHAR(100) NOT NULL -- Description of refund status (e.g., Pending, Approved, Rejected)
);

-- Refunds Table: Stores refund information for each order
CREATE TABLE orders.refunds (
    refund_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,  -- Unique identifier for each refund
    order_id UUID NOT NULL,                               -- FK to orders table
    payment_transaction_id UUID NOT NULL,                 -- FK to payments table
    refund_amount DECIMAL(10, 2) NOT NULL,                -- Refund amount
    refund_status_id INT,                                 -- FK to refund_status_mapping table
    refund_date TIMESTAMP DEFAULT clock_timestamp() NOT NULL, -- Date when refund was initiated
    reason VARCHAR(255),                                  -- Reason for refund
    created_at TIMESTAMP DEFAULT clock_timestamp(),       -- Timestamp of refund creation
    created_by VARCHAR(50),                               -- Identifier of who created the record
    updated_at TIMESTAMP DEFAULT clock_timestamp(),       -- Timestamp of last update
    updated_by VARCHAR(50),                               -- Identifier of who last updated the record
    CONSTRAINT fk_refunds_order FOREIGN KEY (order_id) REFERENCES orders.orders(order_id),
    CONSTRAINT fk_refunds_payment FOREIGN KEY (payment_transaction_id) REFERENCES orders.payments(payment_transaction_id),
    CONSTRAINT fk_refunds_status FOREIGN KEY (refund_status_id) REFERENCES orders.refund_status_mapping(refund_status_id)
);


-- Insert predefined statuses into payment_mapping table
INSERT INTO orders.payment_mapping (payment_method, payment_status) VALUES 
('Credit Card', 'Pending'),
('Credit Card', 'Completed'),
('Credit Card', 'Failed'),
('PayPal', 'Pending'),
('PayPal', 'Completed'),
('PayPal', 'Failed');

-- Insert predefined statuses into order_status_mapping table
INSERT INTO orders.order_status_mapping (status_description) VALUES
('Pending'),
('Shipped'),
('Delivered'),
('Cancelled'),
('Returned'),
('Refunded');

-- Insert predefined statuses into refund_status_mapping table
INSERT INTO orders.refund_status_mapping (refund_status_description) VALUES
('Pending'),
('Approved'),
('Rejected'),
('Processed'),
('Completed');

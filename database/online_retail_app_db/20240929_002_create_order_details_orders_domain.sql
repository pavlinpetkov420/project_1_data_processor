-- Create table that will store each product in order

CREATE TABLE orders.order_details(
    detail_id uuid DEFAULT gen_random_uuid() NOT NULL
    , order_id uuid --FK to orders.orders
    , product_id uuid -- FK products.products
    , quantity INTEGER NOT NULL
    , total_detail_price DECIMAL(19,2) NOT NULL
    , total_discounted_price DECIMAL(19,2) DEFAULT 0
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_order_details PRIMARY KEY (detail_id)
);

ALTER TABLE orders.order_details
    ADD CONSTRAINT fk_orders_order_details
        FOREIGN KEY (order_id) 
        REFERENCES orders.orders (order_id);

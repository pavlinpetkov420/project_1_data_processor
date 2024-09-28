/*
Fixing issues for orders domain:
1. Add customers.delivery_addresses FK connetion between orders and customers 

Update: At documentation\BusinessProblem.md we have a business condition to create 
separate tables that will persist orders deliveries and their statuses 
*/

ALTER TABLE orders.orders
    ADD delivery_address_id uuid NOT NULL;

ALTER TABLE orders.orders
    ADD CONSTRAINT fk_orders_delivery_addresses
        FOREIGN KEY (delivery_address_id)
        REFERENCES customers.delivery_addresses(delivery_address_id);

ALTER TABLE orders.orders
	DROP CONSTRAINT fk_orders_delivery_addresses;

ALTER TABLE orders.orders
	DROP COLUMN delivery_address_id;
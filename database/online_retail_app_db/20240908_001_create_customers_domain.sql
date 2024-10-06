-- Log In with SUPERUSER to create new schema and add it to search_path
CREATE SCHEMA IF NOT EXISTS customers AUTHORIZATION p1dp_ora_dba;

SET search_path TO public, employees, vendors, customers;

SHOW search_path;

/*
users - Stores user credentials and ties to customer information.
- user_id         - Unique identifier for the user.
- username        - Username for the account.
- email (PK)      - Unique email address, part of the composite primary key.
- password        - Hashed password for authentication.
- customer_id (FK)- Links to the `customers` table (one-to-one).
- created_at      - Timestamp of user creation.
- created_by      - Identifier of who created the record (user or system).
- updated_at      - Timestamp of last update.
- updated_by      - Identifier of who last updated the record.
*/
CREATE TABLE customers.users (
    user_id uuid DEFAULT gen_random_uuid() NOT NULL -- PK & FK
    , username varchar(50) NOT NULL
    , email VARCHAR(100) NOT NULL
    , password VARCHAR(30) NOT NULL
    , customer_id uuid NULL
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_users PRIMARY KEY (user_id)
);

/*
customers - Stores personal information about customers, with a relation to the users table.
- customer_id (PK) - Unique identifier for the customer.
- email (FK, PK)   - Unique email associated with the customer, part of composite primary key.
- user_id (FK)     - Links to the `users` table (one-to-one).
- first_name       - Customer's first name.
- last_name        - Customer's last name.
- address          - Primary address for the customer.
- city             - City of the primary address.
- country          - Country of the primary address.
- postal_code      - Postal code of the primary address.
- phone_number     - Customer's contact phone number.
- created_at       - Timestamp of customer creation.
- created_by       - Identifier of who created the record.
- updated_at       - Timestamp of last update.
- updated_by       - Identifier of who last updated the record.
*/

CREATE TABLE customers.customers(
    customer_id uuid DEFAULT gen_random_uuid() NOT NULL -- PK
    , email VARCHAR(100) NOT NULL
    , user_id uuid -- FK
    , first_name VARCHAR(100) NOT NULL
    , last_name VARCHAR(100) NOT NULL
    , address VARCHAR(100) NOT NULL
    , city VARCHAR(100) NOT NULL
    , country VARCHAR(100) NOT NULL
    , postal_code VARCHAR(100) NOT NULL
    , phone_number VARCHAR(10) NOT NULL
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_customers PRIMARY KEY (customer_id)
);

/*
delivery_addresses - Stores multiple delivery addresses for customers.
- delivery_address_id (PK) - Unique identifier for the delivery address.
- customer_id (FK)         - Links to the `customers` table.
- country                 - Country of the delivery address.
- city                    - City of the delivery address.
- postal_code             - Postal code for the delivery address.
- address                 - Street and number of the delivery address.
- created_at              - Timestamp of creation.
- created_by              - Identifier of who created the record.
- updated_at              - Timestamp of last update.
- updated_by              - Identifier of who last updated the record.
*/

CREATE TABLE customers.delivery_addresses(
    delivery_address_id uuid DEFAULT gen_random_uuid() NOT NULL -- PK
    , customer_id uuid  -- FK
    , address VARCHAR(100) NOT NULL
    , city VARCHAR(100) NOT NULL
    , country VARCHAR(100) NOT NULL
    , postal_code VARCHAR(100) NOT NULL
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_delivery_addresses PRIMARY KEY (delivery_address_id)
);

/*
user_login_history - Tracks login activity of users.
- id (PK)          - Unique identifier for the login history record.
- user_id (FK)     - Links to the `users` table.
- last_login_at    - Timestamp of the last login.
- ip_address       - (Optional) Records the IP address of the login.
- device_info      - (Optional) Records details about the device used.
- created_at       - Timestamp of record creation (same as login time).
- created_by       - Identifier of who created the record (system).
- updated_at       - Timestamp of last update (if necessary).
- updated_by       - Identifier of who last updated the record.
*/

CREATE TABLE customers.user_login_history(
    user_login_history_id uuid DEFAULT gen_random_uuid() NOT NULL -- PK
    , user_id uuid NOT NULL -- FK
    , last_login_at timestamp DEFAULT clock_timestamp() NOT NULL 
    , ip_address VARCHAR(15) NOT NULL
    , device_info VARCHAR(200)
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_user_login_history PRIMARY KEY (user_login_history_id)
); 

-- USERS CONSTRAINTS
ALTER TABLE customers.users 
    ADD CONSTRAINT fk_users_customers
    FOREIGN KEY (customer_id) 
    REFERENCES customers.customers(customer_id);

ALTER TABLE customers.users 
    ADD CONSTRAINT chk_users_email_format
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- CUSTOMERS CONSTRAINTS
ALTER TABLE customers.customers 
    ADD CONSTRAINT chk_customers_email_format
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- DELIVERY ADDRESSES
ALTER TABLE customers.delivery_addresses 
    ADD CONSTRAINT fk_delivery_addresses_customers
    FOREIGN KEY (customer_id) 
    REFERENCES customers.customers(customer_id);

-- USER_LOGIN_HISTORY CONSTRAINTS
ALTER TABLE customers.user_login_history 
    ADD CONSTRAINT fk_users_user_login_history
    FOREIGN KEY (user_id) 
    REFERENCES customers.users(user_id);


-- DROP TABLE customers.users;
-- DROP TABLE customers.customers;
-- DROP TABLE customers.delivery_addresses;
-- DROP TABLE customers.user_login_history;
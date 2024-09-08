-- Log In with SUPERUSER to create new schema and add it to search_path
CREATE SCHEMA IF NOT EXISTS vendors AUTHORIZATION p1dp_ora_dba;

SET search_path TO public, employees, vendors;

SHOW search_path;

-- Double check search path before create tables!

-- Vendor
-- vendor_id (PK): Unique identifier for the vendor.
-- name: Name of the vendor.
-- vendor_type_id (FK): Reference to the vendor_type table.
-- contract_id (FK, can be NULL if no contract): Reference to the vendor_contracts table.
-- phone_number: Contact phone number.
-- primary_contact_name: Name of the primary contact person.
-- created_by: User ID or name of the person who created the record.
-- created_at: Timestamp when the record was created.
-- updated_by: User ID or name of the person who last updated the record.
-- updated_at: Timestamp when the record was last updated.

CREATE TABLE vendors.vendor (
    vendor_id uuid DEFAULT gen_random_uuid()
    , vendor_name VARCHAR(100) NOT NULL 
    , vendor_type_id uuid
    , contract_id uuid
    , phone_number VARCHAR(10) NOT NULL
    , primary_contact_name VARCHAR(100) NOT NULL
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_vendor_id PRIMARY KEY (vendor_id)
);

/*
vendor_details Table
vendor_id (PK, FK to vendor.vendor_id): Unique identifier for the vendor, also a foreign key to the vendor table.
address: Address of the vendor.
email: Email address of the vendor.
website_url: URL of the vendor's website.
primary_contact_position: Position of the primary contact person.
secondary_contact_name: Name of the secondary contact person.
secondary_contact_phone: Phone number of the secondary contact person.
secondary_contact_email: Email address of the secondary contact person.
tax_id: Tax identification number of the vendor.
bank_account_number: Bank account number for payments.
bank_name: Name of the bank.
payment_terms: Agreed payment terms (e.g., Net 30).
status: Status of the vendor (e.g., active, inactive).
notes: Additional notes about the vendor.
preferred_delivery_method: Preferred method for receiving purchase orders.
created_by: User ID or name of the person who created the record.
created_at: Timestamp when the record was created.
updated_by: User ID or name of the person who last updated the record.
updated_at: Timestamp when the record was last updated
*/

CREATE TABLE vendors.vendor_details (
    tax_id VARCHAR(100) -- PK
    , vendor_id uuid -- FK REF to vendors
    , address VARCHAR(100) NOT NULL
    , email VARCHAR(100) NULL -- Add check constraint for email
    , website_url VARCHAR(100) NULL
    , primary_contact_position VARCHAR(50) NOT NULL
    , secondary_contact_name VARCHAR(100) NULL
    , secondary_contact_phone VARCHAR(100) NULL
    , secondary_contact_email VARCHAR(100) NULL -- Again check constraint
    , bank_account_number VARCHAR(50)
    , bank_name VARCHAR(100)
    , payment_terms VARCHAR(20) NOT NULL
    , is_active BOOLEAN
    , notes VARCHAR(500) NULL
    , preferred_delivery_method VARCHAR(50) NULL
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_vendor_details PRIMARY KEY (tax_id)
);

/*
vendor_type Table
vendor_type_id (PK): Unique identifier for the vendor type.
vendor_type: Name or category of the vendor type.
description: Description of the vendor type.
created_by: User ID or name of the person who created the record.
created_at: Timestamp when the record was created.
updated_by: User ID or name of the person who last updated the record.
updated_at: Timestamp when the record was last updated.
*/

CREATE TABLE vendors.vendor_type (
    vendor_type_id uuid DEFAULT gen_random_uuid()
    , vendor_type VARCHAR(15) NOT NULL
    , description VARCHAR(100) 
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_vendor_type_id PRIMARY KEY (vendor_type_id)
);

/*
vendor_contracts Table
contract_id (PK): Unique identifier for the contract.
start_date: Start date of the contract.
end_date: End date of the contract.
base_description: Description of the contract terms.
created_by: User ID or name of the person who created the record.
created_at: Timestamp when the record was created.
updated_by: User ID or name of the person who last updated the record.
updated_at: Timestamp when the record was last updated.
*/

CREATE TABLE vendors.vendor_contracts (
    contract_id uuid DEFAULT gen_random_uuid()
    , start_date DATE NOT NULL 
    , end_date DATE NOT NULL
    , base_description VARCHAR(100) NOT NULL
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_vendor_contracts_id PRIMARY KEY (contract_id)
);

-- Foreign Keys
-- vendors 
ALTER TABLE vendors.vendor
    ADD CONSTRAINT fk_vendor_vendor_type FOREIGN KEY (vendor_type_id) 
    REFERENCES vendors.vendor_type (vendor_type_id);

 ALTER TABLE vendors.vendor
    ADD CONSTRAINT fk_vendor_vendor_contracts FOREIGN KEY (contract_id)
    REFERENCES  vendors.vendor_contracts (contract_id);

-- vendor_details
ALTER TABLE vendors.vendor_details
    ADD CONSTRAINT fk_vendor_vendor_details FOREIGN KEY (vendor_id)
    REFERENCES vendors.vendor (vendor_id);

-- Check Constraints
ALTER TABLE vendor_details
ADD CONSTRAINT chk_email_format
CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

ALTER TABLE vendor_details
ADD CONSTRAINT chk_secondary_email_format
CHECK (secondary_contact_email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

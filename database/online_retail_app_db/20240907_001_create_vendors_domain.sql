/*
Vendors will be separated in 4 tables as a start:

Vendor Model

vendor Table
vendor_id (PK): Unique identifier for the vendor.
name: Name of the vendor.
vendor_type_id (FK): Reference to the vendor_type table.
contract_id (FK, can be NULL if no contract): Reference to the vendor_contracts table.
phone_number: Contact phone number.
primary_contact_name: Name of the primary contact person.
created_by: User ID or name of the person who created the record.
created_at: Timestamp when the record was created.
updated_by: User ID or name of the person who last updated the record.
updated_at: Timestamp when the record was last updated.

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
updated_at: Timestamp when the record was last updated.

vendor_type Table
vendor_type_id (PK): Unique identifier for the vendor type.
vendor_type: Name or category of the vendor type.
description: Description of the vendor type.
created_by: User ID or name of the person who created the record.
created_at: Timestamp when the record was created.
updated_by: User ID or name of the person who last updated the record.
updated_at: Timestamp when the record was last updated.

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

-- Log In with SUPERUSER to create new schema and add it to search_path
CREATE SCHEMA IF NOT EXISTS vendors AUTHORIZATION AUTHORIZATION p1dp_ora_dba;

SET search_path "${user}, public, employees, vendors";

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
    vendor_id uuid DEFAUT gen_random_uuid()
    , vendor_name VARCHAR(100) NOT NULL 
    , vendor_type_id uuid
    , contract_id uuid
    , phone_number VARCHAR(10)
    , primary_contact_name VARCHAR(100)
    , created_by VARCHAR(50)
    , created_at TIMESTAMP DEFAULT clock_timestamp()
    , updated_by VARCHAR(50)
    , updated_at TIMESTAMP DEFAULT clock_timestamp()
    , CONSTRAINT pk_vendor_id PRIMARY KEY (vendor_id)
);


-- TODO: Define FKs after all tables are created!
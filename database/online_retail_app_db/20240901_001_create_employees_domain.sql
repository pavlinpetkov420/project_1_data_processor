/*
Employees will be separated in its own schema called employees
Design:
Employees: EmployeeID, FirstName, LastName, Email, Phone, DateOfBirth, ManagerID, PositionID
Departments: DepartmentID, DepartmentName, department_abbreviation
job_Positions: PositionID, PositionTitle, DepartmentID, SalaryRange
*/

-- Schema got created with DB superuser - postgres
-- Using default behavior for ownership of user that executes the command
-- Owner: p1dp_ora_dba
CREATE SCHEMA IF NOT EXISTS employees AUTHORIZATION p1dp_ora_dba;

-- Returned to DBA User, for DB Objects creation
-- Employees Table
CREATE TABLE IF NOT EXISTS employees.employees (
    employee_id uuid DEFAULT gen_random_uuid() 
    , first_name VARCHAR(100) NOT NULL
    , last_name VARCHAR(100) NOT NULL
    , email VARCHAR(50) NOT NULL
    , phone VARCHAR(10)
    , date_of_birth DATE
    , manager_id uuid
    , position_id uuid
    , CONSTRAINT pk_employees_id PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS employees.departments (
    department_id uuid DEFAULT gen_random_uuid()
    , department_name VARCHAR(100) NOT NULL
    , department_abbreviation VARCHAR(10)
    , CONSTRAINT pk_departments_id PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS employees.job_positions (
    position_id uuid DEFAULT gen_random_uuid()
    , position_title VARCHAR(100) NOT NULL
    , department_id uuid -- FK 
    , min_salary money NOT NULL
    , max_salary money NOT NULL
    , CONSTRAINT pk_position_id PRIMARY KEY (position_id)
);

-- Move all FK Constraints to be created after actual relations are created!
-- #1 Not Working 

SHOW SEARCH_PATH;
-- Returned "user" and public which are default. In order to add FK constraints need to add employees schema to search_path

SET search_path TO public, employees;

ALTER TABLE employees.employees
ADD CONSTRAINT fk_employees_managers FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

ALTER TABLE employees.employees
ADD CONSTRAINT fk_employees_job_positions FOREIGN KEY (employee_id) REFERENCES job_positions(position_id);

ALTER TABLE employees.job_positions
ADD CONSTRAINT fk_job_positions_departments FOREIGN KEY (department_id) REFERENCES (departments.department_id);
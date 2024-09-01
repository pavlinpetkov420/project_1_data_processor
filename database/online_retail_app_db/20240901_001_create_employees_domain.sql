/*
Design:
Employees: EmployeeID, FirstName, LastName, Email, Phone, DateOfBirth, ManagerID, PositionID
Departments: DepartmentID, DepartmentName, department_abbreviation
job_Positions: PositionID, PositionTitle, DepartmentID, SalaryRange
*/

-- Employees Table
CREATE TABLE IF NOT EXISTS public.employees (
    employee_id uuid DEFAULT uuid_generate_v4() 
    , first_name VARCHAR(100) NOT NULL
    , last_name VARCHAR(100) NOT NULL
    , email VARCHAR(50) NOT NULL
    , phone VARCHAR(10)
    , date_of_birth DATE
    , manager_id uuid
    , position_id uuid
    , CONSTRAINT pk_employees_id PRIMARY KEY (employee_id)
    -- TODO: Fill FK constraints here or in separate statement
    -- manager_id, position_id
);

CREATE TABLE IF NOT EXISTS public.departments (
    department_id uuid DEFAULT uuid_generate_v4()
    , department_name VARCHAR(100) NOT NULL
    , department_abbreviation VARCHAR(10)
    , CONSTRAINT pk_departments_id PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS public.job_positions (
    position_id uuid DEFAULT uuid_generate_v4()
    , position_title VARCHAR(100) NOT NULL
    , department_id uuid -- FK 
    , min_salary money NOT NULL
    , max_salary money NOT NULL
    -- TODO: FK for department_id
);
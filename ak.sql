

-- CREATE DATABASE employee_payroll;
-- -- USE employee_payroll;
-- -- CREATE TABLE employee (
-- --     id INT AUTO_INCREMENT PRIMARY KEY,
-- --     employee_id varchar(100) not null,
-- --     fullname VARCHAR(100) NOT NULL,
-- --     email VARCHAR(100) NOT NULL UNIQUE,
-- --     username VARCHAR(50) NOT NULL UNIQUE,
-- --     password VARCHAR(255) NOT NULL,
-- --     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- -- );
-- -- INSERT INTO employee (employee_id,fullname, email, username, password)
-- -- VALUES (12345678,'John Doe', 'john@example.com', 'johndoe', '$2y$12$examplehashedpassword');
-- -- INSERT INTO employee (employee_id,fullname, email, username, password)
-- -- VALUES (234567,'wick', 'wick@example.com', 'wickdog', '$2y$12$examplehashedpassword');

-- -- select * from employee;
-- -- ALTER TABLE employee
-- -- ADD INDEX idx_employee_id (employee_id);
-- -- -- Create a new table to track attendance
-- -- CREATE TABLE attendance (
-- --     id INT AUTO_INCREMENT PRIMARY KEY,
-- --     employee_id VARCHAR(20) NOT NULL,
-- --     month VARCHAR(20) NOT NULL,
-- --     year INT NOT NULL,
-- --     days_present INT NOT NULL,
-- --     FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
-- -- );

-- -- select * from attendance;
-- -- drop table attendance;
-- -- ALTER TABLE employee
-- -- ADD COLUMN role ENUM('manager', 'employee') NOT NULL DEFAULT 'employee';
-- -- UPDATE employee SET role = 'manager' WHERE username = 'johndoe'; -- Example username for manager
-- -- delete 	from employee where id=3;



-- -- Use the employee_payroll database
-- USE employee_payroll;

--  drop table attendance;
-- drop table employee;

-- -- Create employee table
-- CREATE TABLE employee (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     employee_id varchar(100) not null,
--     fullname VARCHAR(100) NOT NULL,
--     email VARCHAR(100) NOT NULL UNIQUE,
--     username VARCHAR(50) NOT NULL UNIQUE,
--     password VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- -- Insert sample employees
-- INSERT INTO employee (employee_id,fullname, email, username, password)
-- VALUES (12345678,'John Doe', 'john@example.com', 'johndoe', '$2y$12$examplehashedpassword');

-- INSERT INTO employee (employee_id,fullname, email, username, password)
-- VALUES (234567,'wick', 'wick@example.com', 'wickdog', '$2y$12$examplehashedpassword');

-- -- View employee records
-- SELECT * FROM employee;

-- -- Add index for employee_id for optimization
-- ALTER TABLE employee
-- ADD INDEX idx_employee_id (employee_id);

-- -- Drop attendance table if exists
-- DROP TABLE IF EXISTS attendance;

-- -- Create a new attendance table
-- CREATE TABLE attendance (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     employee_id VARCHAR(20) NOT NULL,
--     month VARCHAR(20) NOT NULL,
--     year INT NOT NULL,
--     days_present INT NOT NULL,
--     FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
-- );

-- -- View attendance table
-- SELECT * FROM attendance;

-- -- Add role column to employee table
-- ALTER TABLE employee
-- ADD COLUMN role ENUM('manager', 'employee') NOT NULL DEFAULT 'employee';

-- -- Update specific employee's role to manager
-- UPDATE employee 
-- SET role = 'manager' 
-- WHERE username = 'johndoe';

-- -- Delete a specific employee record by ID
-- DELETE FROM employee 
-- WHERE id = 3;

-- -- Update other fields in the employee table (Example update query for password)
-- UPDATE employee 
-- SET password = '$2y$12$updatedHashedPassword' 
-- WHERE username = 'wickdog';


CREATE DATABASE payroll;
USE payroll;

CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id VARCHAR(100) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('manager', 'employee') NOT NULL DEFAULT 'employee',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employee (employee_id, fullname, email, username, password, role)
VALUES ('12345678', 'John Doe', 'john@example.com', 'johndoe', '$2y$12$examplehashedpassword', 'manager'),
       ('23456789', 'Jane Smith', 'jane@example.com', 'janesmith', '$2y$12$examplehashedpassword', 'employee');
select * from employee;

ALTER TABLE employee ADD COLUMN working_days INT DEFAULT 0;
ALTER TABLE employee ADD COLUMN working_days INT DEFAULT 0;
delete from employee where id=4;
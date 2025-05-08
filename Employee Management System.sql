CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

CREATE TABLE Departments (
    departmentId INT PRIMARY KEY,
    departmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    employeeId INT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Departments(departmentId)
);

CREATE TABLE Projects (
    projectId INT PRIMARY KEY,
    projectName VARCHAR(100) NOT NULL,
    projectBudget DECIMAL(10,2) NOT NULL,
    managerId INT,
    FOREIGN KEY (managerId) REFERENCES Employees(employeeId)
);


INSERT INTO Departments VALUES (1, 'Human Resources');
INSERT INTO Departments VALUES (2, 'Engineering');
INSERT INTO Departments VALUES (3, 'Marketing');

INSERT INTO Employees VALUES (1, 'Alice', 'Johnson', 30, 'alice.johndon@example.com', 1);
INSERT INTO Employees VALUES (2, 'Bob', 'Smith', 45, 'bob.smith@example.com', 2);
INSERT INTO Employees VALUES (3, 'Chars', 'Carl', 25, 'chars.carl@example.com', 3);
INSERT INTO Employees VALUES (4, 'Dave', 'Brown', 38, 'dave.brown@example.com', 2);
INSERT INTO Employees VALUES (5, 'Ever', 'Heart', 28, 'ever.heart@example.com', 1);

INSERT INTO Projects VALUES (101, 'Website Redesign', 5000.00, 2);
INSERT INTO Projects VALUES (102, 'Training Program', 1500.00, 1);
INSERT INTO Projects VALUES (103, 'Sales Improvement', 2000.00, 3);


SELECT Employees.firstName, Employees.lastName, Departments.departmentName
FROM Employees
JOIN Departments ON Employees.departmentId = Departments.departmentId;

SELECT Projects.projectName, Projects.projectBudget, Employees.firstName, Employees.lastName
FROM Projects
JOIN Employees ON Projects.managerId = Employees.employeeId;

SELECT Employees.firstName, Employees.lastName, Employees.age, Departments.departmentName
FROM Employees
JOIN Departments ON Employees.departmentId = Departments.departmentId
WHERE Employees.age > 40 AND Departments.departmentName = 'Engineering';


CREATE VIEW EmployeeDetails AS
SELECT Employees.employeeId, Employees.firstName, Employees.lastName, Departments.departmentName
FROM Employees
JOIN Departments ON Employees.departmentId = Departments.departmentId;

SELECT * FROM EmployeeDetails;

CREATE VIEW ActiveProjects AS
SELECT projectName, projectBudget, managerId
FROM Projects
WHERE projectBudget > 1000;

SELECT * FROM ActiveProjects;
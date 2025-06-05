--CREATE TABLE Employees (
--    EmployeeID INT PRIMARY KEY,
--    FirstName NVARCHAR(50),
--    LastName NVARCHAR(50),
--    Email NVARCHAR(100) UNIQUE,
--    DepartmentID INT,
--    HireDate DATE,
--    Salary DECIMAL(10, 2)
--);


--INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate, Salary)
--VALUES 
--(1, 'John', 'Smith', 'john.smith@example.com', 101, '2021-06-15', 75000.00),
--(2, 'Jane', 'Doe', 'jane.doe@example.com', 102, '2020-03-10', 85000.00),
--(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 101, '2019-11-22', 95000.00),
--(4, 'Emily', 'Davis', 'emily.davis@example.com', 103, '2022-01-05', 68000.00),
--(5, 'William', 'Brown', 'william.brown@example.com', 102, '2018-07-19', 80000.00);


SELECT * FROM EMPLOYEES; 

--Write a SQL query to find the names of employees who have a salary higher than the average salary of all employees.

SELECT FIRSTNAME,LASTNAME,SALARY FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) 

--Write a SQL query to list the employee names and their departments for employees who were hired after the oldest employee in the company.
SELECT FIRSTNAME,LASTNAME, DEPARTMENTID FROM EMPLOYEES WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EMPLOYEES)

--Write a SQL query to find the details of the employee(s) with the highest salary.
SELECT * FROM EMPLOYEES WHERE EMPLOYEEID = (SELECT EMPLOYEEID FROM EMPLOYEES WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES))

--Write a SQL query to find the names of employees who work in the same department as 'John Smith'.
SELECT FIRSTNAME,LASTNAME,DEPARTMENTID FROM EMPLOYEES WHERE DEPARTMENTID IN (SELECT DISTINCT DEPARTMENTID FROM EMPLOYEES) ORDER BY DEPARTMENTID;

--Write a SQL query to find the names of employees who do not belong to the department with the highest average salary.
SELECT * FROM EMPLOYEES WHERE DEPARTMENTID = (SELECT DEPARTMENTID FROM EMPLOYEES GROUP BY DEPARTMENTID HAVING AVG(SALARY) <= (SELECT AVG(SALARY) FROM EMPLOYEES))
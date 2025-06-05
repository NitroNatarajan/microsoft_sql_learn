-- Creating the Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);


-- Inserting data into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(101, 'Human Resources'),
(102, 'Finance'),
(103, 'IT');


--Write a SQL query to list the names of employees along with the names of the departments they work in.
select e.firstname, e.lastname, e.departmentid, d.departmentname from employees e join departments d on d.departmentid = e.departmentid

--Write a SQL query to list all the departments and the employees working in them, including departments with no employees.
select departments.departmentid,departmentname , employees.employeeid,employees.firstname,employees.lastname from employees right join 
departments on departments.departmentid = employees.departmentid 
order by departments.departmentid

--Write a SQL query to find the names of employees who do not belong to any department (i.e., no matching department ID).
select employees.firstname, employees.lastname from employees left join departments on employees.departmentid = departments.departmentid where departments.departmentid is null;

--Write a SQL query to list the names of employees who work in the same department as 'Jane Doe'.
select * from employees join departments on departments.departmentid = employees.departmentid 
where employees.departmentid = (select departmentid from employees where concat(firstname, space(1),lastname) = 'Jane Doe') 


--Write a SQL query to find the department with the highest total salary paid to its employees.
select top 1 employees.departmentid , sum(salary) as total_salary from employees join departments on employees.departmentid = departments.departmentid 
group by employees.departmentid order by total_salary desc 
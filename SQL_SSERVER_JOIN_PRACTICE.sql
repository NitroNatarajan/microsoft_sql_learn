

use [SQL Questions]

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES 
(1, 'Alice', 'USA'),
(2, 'Bob', 'UK'),
(3, 'Charlie', 'Canada'),
(4, 'David', 'USA'),
(5, 'Eve', 'Australia');

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID)
VALUES 
(101, 1, '2024-08-01', 1001),
(102, 1, '2024-08-03', 1002),
(103, 2, '2024-08-04', 1001),
(104, 3, '2024-08-05', 1003),
(105, 5, '2024-08-06', 1004);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1001, 'Laptop', 1000),
(1002, 'Smartphone', 700),
(1003, 'Tablet', 500),
(1004, 'Headphones', 200),
(1005, 'Smartwatch', 300);


select * from Customers

select * from Orders

select * from Products


--1) Write an SQL query to find the names of customers who have placed an order.
select c.CustomerID,c.CustomerName, o.OrderID, o.ProductID ,p.ProductName from Customers c join Orders o on c.customerid = o.CustomerID join Products p on p.ProductID = o.ProductID

--2) Find the list of customers who have not placed any orders.
select c.customerid , o.orderid ,c.customername from customers c left join orders o on o.customerid = c.customerid where OrderID is null; 

--3) List all orders along with the product name and price.
select o.* , p.ProductID , p.Price from  orders o join products p on p.ProductID = o.ProductID 

--4) Find the names of customers and their orders, including customers who haven't placed any orders.
select c.customerid , o.orderid ,c.customername from customers c left join orders o on o.customerid = c.customerid 

--5) Retrieve a list of products that have never been ordered.
select p.* , o.orderid from products p left join orders o on o.productid = p.productid where orderid is null;

--6) Find the total number of orders placed by each customer.
select c.customerid, count(o.OrderID) as [No Of Orders] from customers c left join orders o on o.customerid=c.customerid group by c.customerid order by [No Of Orders] desc;
select c.CustomerName, count(o.OrderID) as [No Of Orders] from customers c left join orders o on o.customerid=c.customerid group by c.CustomerName order by [No Of Orders] desc;


--7) Display the customers, the products they've ordered, and the order date. Include customers who haven't placed any orders.

select c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate ,p.productid, p.productname from customers c left join orders o on o.customerid = c.customerid left join products p on p.productid = o.productid 

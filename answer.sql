-- WEEK 6 ASSIGNMENT: SQL JOINS AND RELATIONSHIPS

-- QUESTION 1: INNER JOIN - Employees and Offices

SELECT
    employees.firstName,
    employees.lastName,
    employees.email,
    employees.officeCode
FROM employees
INNER JOIN offices
    ON employees.officeCode = offices.officeCode;


-- QUESTION 2: LEFT JOIN - Products and Product Lines

SELECT
    products.productName,
    products.productVendor,
    productlines.productLine
FROM products
LEFT JOIN productlines
    ON products.productLine = productlines.productLine;


-- QUESTION 3: RIGHT JOIN - Customers and Orders

SELECT
    orders.orderDate,
    orders.shippedDate,
    orders.status,
    orders.customerNumber,
    customers.customerName
FROM customers
RIGHT JOIN orders
    ON customers.customerNumber = orders.customerNumber
LIMIT 10;



-- =========================================
-- WEEK 7: DATABASE DESIGN AND NORMALIZATION
-- =========================================

USE sales;


-- =========================================
-- QUESTION 1: FIRST NORMAL FORM (1NF)
-- =========================================

-- Create ProductDetail_1NF table

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);

-- Insert normalized records

INSERT INTO ProductDetail_1NF
(OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Display Question 1 results

SELECT * FROM ProductDetail_1NF;


-- =========================================
-- QUESTION 2: SECOND NORMAL FORM (2NF)
-- =========================================

-- Partial dependency:
-- CustomerName depends only on OrderID.
-- It does not depend on the complete composite key.
-- Therefore, CustomerName is stored in a separate table.


-- Create Orders table

CREATE TABLE Week7_Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table

CREATE TABLE Week7_OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID)
    REFERENCES Week7_Orders(OrderID)
);

-- Insert order information

INSERT INTO Week7_Orders
(OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert product and quantity information

INSERT INTO Week7_OrderItems
(OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Display Orders table

SELECT * FROM Week7_Orders;

-- Display OrderItems table

SELECT * FROM Week7_OrderItems;

-- Join both tables

SELECT
    Week7_Orders.OrderID,
    Week7_Orders.CustomerName,
    Week7_OrderItems.Product,
    Week7_OrderItems.Quantity
FROM Week7_Orders
INNER JOIN Week7_OrderItems
ON Week7_Orders.OrderID =
   Week7_OrderItems.OrderID;


-- =========================================
-- END OF WEEK 7 ASSIGNMENT
-- =========================================

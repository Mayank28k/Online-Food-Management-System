-- STEP 1: Create Database
CREATE DATABASE OnlineFood_db;

-- STEP 2: Use Database
USE OnlineFood_db;

-- Create ENUM types
CREATE TYPE order_status AS ENUM ('Placed', 'Preparing', 'Out for Delivery', 'Delivered', 'Cancelled');
CREATE TYPE payment_method AS ENUM ('Card', 'Cash', 'UPI', 'Wallet');
CREATE TYPE payment_status AS ENUM ('Success', 'Failed', 'Pending');

-- STEP 3: Create Tables
-- Customers Table
CREATE TABLE Customers(
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(120),
    EmailID VARCHAR(120) UNIQUE,
    Contact INT,
	FlatNo VARCHAR(20),
	Street VARCHAR(100),
    City VARCHAR(40),
	State VARCHAR(50),
	Country VARCHAR(50),
	PinCode VARCHAR(20)
);

-- Restaurants Table
CREATE TABLE Restaurants(
    RestaurantID VARCHAR(10) PRIMARY KEY,
    RestaurantName VARCHAR(120),
    Location VARCHAR(120),
    Contact INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5)
);

-- MenuItems Table
CREATE TABLE MenuItems(
    ItemID VARCHAR(10) PRIMARY KEY,
    RestaurantID VARCHAR(10) REFERENCES Restaurants(RestaurantID),
    ItemName VARCHAR(120),
    Description TEXT,
    Rate DECIMAL(8,2),
    Category VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders(
    OrderID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) REFERENCES Customers(CustomerID),
    RestaurantID VARCHAR(10) REFERENCES Restaurants(RestaurantID),
    OrderDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status order_status,
    TotalAmount DECIMAL(8,2)
);

-- OrderItems Table
CREATE TABLE OrderItems(
    OrderItemID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) REFERENCES Orders(OrderID),
    ItemID VARCHAR(10) REFERENCES MenuItems(ItemID),
    Quantity INT,
    Rate DECIMAL(8,2)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) REFERENCES Orders(OrderID),
    PaymentDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AmountPaid DECIMAL(10,2),
    PaymentMethod payment_method,
    PaymentStatus payment_status
);

-- Reviews Table
CREATE TABLE Reviews (
    ReviewID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) REFERENCES Customers(CustomerID),
    RestaurantID VARCHAR(10) REFERENCES Restaurants(RestaurantID),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Inserting values into each table

INSERT INTO Customers VALUES('C-01','Abhishek Sharma', 'abhi@example.com', 100000001, 'A-01', 'Lajpat Nagar', 'Delhi', 'Delhi', 'India', '110024'),
('C-02','Sunil Singh', 'sunil@example.com', 100000002, 'B-02', 'Rohini', 'Delhi', 'Delhi', 'India', '110085'),
('C-03','Mayank Kumar', 'mayank@example.com', 100000003, 'C-03', 'Saket', 'Delhi', 'Delhi', 'India', '110017'),
('C-04','Rohit Sharma', 'sharma@example.com', 100000004, 'D-04', 'Lajpat Nagar', 'Delhi', 'Delhi', 'India', '110024'),
('C-05','Manvi Gupta', 'manvi@example.com', 100000005, 'E-05', 'Dwarka', 'Delhi', 'Delhi', 'India', '110075'),
('C-06','Ritika Mehra', 'ritika@example.com', 100000006, 'F-06', 'Mayur Vihar', 'Delhi', 'Delhi', 'India', '110091'),
('C-07','Rohit Verma', 'rohit@example.com', 100000007, 'G-07', 'Sadar Bazaar', 'Delhi', 'Delhi', 'India', '110006'),
('C-08','Kavya Maran', 'kavya@example.com', 100000008, 'H-08', 'Janakpuri', 'Delhi', 'Delhi', 'India', '110058'),
('C-09','Virat Kohli', 'kohli@example.com', 100000009, 'I-09', 'Nehru Place', 'Delhi', 'Delhi', 'India', '110019'),
('C-10','Anushka Sharma', 'annu@example.com',100000010, 'J-10', 'Sadar Bazaar', 'Delhi', 'Delhi', 'India', '110006');

Update customers set flatno='A-1' where customerid='C-01';
Update customers set flatno='B-1' where customerid='C-02';
Update customers set flatno='C-1' where customerid='C-03';
Update customers set flatno='D-1' where customerid='C-04';
Update customers set flatno='E-1' where customerid='C-05';
Update customers set flatno='F-1' where customerid='C-06';
Update customers set flatno='G-1' where customerid='C-07';
Update customers set flatno='H-1' where customerid='C-08';
Update customers set flatno='I-1' where customerid='C-09';
Update customers set flatno='J-1' where customerid='C-10';

INSERT INTO Restaurants VALUES('R-1','Taste of Delhi', 'Lajpat Nagar, Delhi', 110000001, 4),
('R-2','Urban Chakhna', 'Rohini, Delhi', 110000002, 5),
('R-3','Swaad-e-Dilli', 'Saket, Delhi', 110000003, 4),
('R-4','Punjabi Dhaba', 'Lajpat Nagar, Delhi', 110000004, 5),
('R-5','Tandoori Treats', 'Dwarka, Delhi', 110000005, 3),
('R-6','Chatori Gully', 'Mayur Vihar, Delhi', 110000006, 4),
('R-7','Delhi Biryani Co.', 'Sadar Bazaar, Delhi', 110000007, 5),
('R-8','Ghar Ki Rasoi', 'Janakpuri, Delhi', 110000008, 3),
('R-9','Spice Square', 'Nehru Place, Delhi', 110000009, 4),
('R-10','Capital Cuisines', 'Sadar Bazaar, Delhi', 110000010, 4);

INSERT INTO MenuItems VALUES('IT-1','R-1', 'Chole Bhature', 'Classic Delhi street food', 70.00, 'Main Course'),
('IT-2','R-2', 'Rajma Chawal', 'North Indian staple', 90.00, 'Main Course'),
('IT-3','R-3', 'Kadhi Chawal', 'North Indian staple', 70.00, 'Main Course'),
('IT-4','R-4', 'Butter Chicken', 'Creamy chicken curry', 220.00, 'Main Course'),
('IT-5','R-5', 'Naan', 'Indian bread', 30.00, 'Breads'),
('IT-6','R-6', 'Cold Coffee', 'Chilled beverage', 80.00, 'Beverages'),
('IT-7','R-7', 'Mutton Biryani', 'Delicious spiced rice', 250.00, 'Main Course'),
('IT-8','R-8', 'Paneer Tikka', 'Grilled cottage cheese', 180.00, 'Starters'),
('IT-9','R-9', 'Tandoori Roti', 'Baked whole wheat bread', 25.00, 'Breads'),
('IT-10','R-10', 'Kadai Paneer', 'Spicy paneer curry', 200.00, 'Main Course');

INSERT INTO Orders(OrderID, CustomerID, RestaurantID, Status, TotalAmount) VALUES
('O-1','C-01', 'R-1', 'Placed', 70.00),
('O-2','C-02', 'R-2', 'Delivered', 90.00),
('O-3','C-03', 'R-3', 'Preparing', 70.00),
('O-4','C-04', 'R-4', 'Out for Delivery', 250.00),
('O-5','C-05', 'R-5', 'Cancelled', 0.00),
('O-6','C-06', 'R-6', 'Delivered', 80.00),
('O-7','C-07', 'R-7', 'Placed', 250.00),
('O-8','C-08', 'R-8', 'Delivered', 180.00),
('O-9','C-09', 'R-9', 'Preparing', 25.00),
('O-10','C-10','R-10', 'Placed', 200.00);

INSERT INTO OrderItems VALUES('OIT-1', 'O-1', 'IT-1', 1, 70.00),
('OIT-2','O-2','IT-2', 1, 90.00),
('OIT-3','O-3', 'IT-3', 1, 70.00),
('OIT-4','O-4', 'IT-4', 1, 220.00),
('OIT-5','O-4', 'IT-5', 1, 30.00),
('OIT-6','O-6', 'IT-6', 1, 80.00),
('OIT-7','O-7', 'IT-7', 1, 250.00),
('OIT-8','O-8', 'IT-8', 1, 180.00),
('OIT-9','O-9', 'IT-9', 1, 25.00),
('OIT-10','O-10','IT-10', 1, 200.00);

INSERT INTO Payments (PaymentID, OrderID, AmountPaid, PaymentMethod, PaymentStatus) VALUES
('P-1','O-1', 70.00, 'Cash', 'Success'),
('P-2','O-2', 90.00, 'UPI', 'Success'),
('P-3','O-3', 70.00, 'Card', 'Pending'),
('P-4','O-4', 250.00, 'UPI', 'Pending'),
('P-5','O-5', 0.00, 'Cash', 'Failed'),
('P-6','O-6', 80.00, 'Wallet', 'Success'),
('P-7','O-7', 250.00, 'Card', 'Success'),
('P-8','O-8', 180.00, 'Cash', 'Success'),
('P-9','O-9', 25.00, 'UPI', 'Failed'),
('P-10','O-10', 200.00, 'Card', 'Success');

INSERT INTO Reviews(ReviewID, CustomerID, RestaurantID, Rating, Comment) 
VALUES('RE-1','C-01', 'R-1', 5, 'Taste was fabulous!'),
('RE-2','C-02', 'R-2', 4, 'Nice rajma, felt homely'),
('RE-3','C-03', 'R-3', 3, 'Kadhi chawal was average'),
('RE-4','C-04', 'R-4', 5, 'Butter chicken was yummy!'),
('RE-5','C-05', 'R-5', 2, 'Naan was cold'),
('RE-6','C-06', 'R-6', 4, 'Refreshing coffee'),
('RE-7','C-07', 'R-7', 1, 'Tasteless biryani!'),
('RE-8','C-08', 'R-8', 3, 'Paneer tikka was dry'),
('RE-9','C-09', 'R-9', 5, 'Roti was perfect and soft'),
('RE-10','C-10', 'R-10', 4, 'Good curry, decent price');



select * from customers;
select * from restaurants;
select * from menuitems;
select * from orders;
select * from  orderitems;
select * from payments;
select * from reviews;

--QUERIES
--customers who have 'placed' order_status.
select c.customerid, c.customername, c.contact, o.status
from customers as c inner join orders as o on c.customerid = o.customerid
where o.status = 'Placed';

--total number of orders for each restaurant
select r.restaurantid, r.restaurantname, count(o.orderid) as Total_Orders
from restaurants as r inner join orders as o on r.restaurantid=o.restaurantid
group by r.restaurantid, r.restaurantname
order by r.restaurantid;

--items ordered by a particular customer
select m.itemid, m.itemname from menuitems as m inner join orders as o  
on m.restaurantid=o.restaurantid inner join customers as c on c.customerid=o.customerid
where c.customername='Mayank Kumar';

--list down items under specific category
select itemid,itemname, rate from menuitems where category='Main Course';

--Show the most recent 5 orders.
select orderid, orderdatetime, totalamount, status
from orders order by orderdatetime desc
limit 5;

--Show all reviews for a specific restaurant 
select r.reviewid,r.restaurantid,rt.restaurantname, r.rating, r.comment  
from reviews as r inner join restaurants as rt on r.restaurantid=rt.restaurantid
where rt.restaurantname='Taste of Delhi';




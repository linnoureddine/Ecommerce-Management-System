Create Database EnvisionTech;

Use EnvisionTech;

Create table ADMIN(
AdminID int identity(100,1),
Name varchar(50) NOT NULL,
PhoneNumber varchar(20) NOT NULL,
Email varchar(100) NOT NULL,
Password varchar(20) NOT NULL,
Country varchar(50) NOT NULL,
Role varchar(100) NOT NULL,
StartDate date NOT NULL,
Primary key(AdminID)
);

Create table Customer(
CustomerID int identity(200,1) NOT NULL,
Name varchar(50) NOT NULL,
PhoneNumber varchar(20) NOT NULL,
Email varchar(100) NOT NULL,
Password varchar(20) NOT NULL,
Country varchar(50) NOT NULL,
DateJoined date NOT NULL,
Primary key(CustomerID)
);

Create table Category(
CategoryID int identity(300,1) ,
CategoryName varchar(50) NOT NULL,
Primary key(CategoryID)
);

Create table Product(
CategoryID int,
ProductID int identity(1,1),
ProductName varchar(100) NOT NULL,
Price float NOT NULL,
Discount float,
QuantityInStock int NOT NULL,
Description varchar(500) NOT NULL,
Rating float NOT NULL,
Primary key(ProductID),
foreign key (CategoryID) references Category (CategoryID) on delete cascade on update cascade,
);

Create table Image(
ProductID int,
ImageID int,
Image varbinary(MAX),
Primary key(ImageID),
Foreign key (ProductID) references Product (ProductID) on delete cascade on update cascade
);

Create table Cart(
CustomerID int UNIQUE,
CartID int identity(400,1),
TotalPrice float NOT NULL default(0),
Primary key(CartID),
Foreign key (CustomerID) references Customer (CustomerID) on delete cascade on update cascade
);

Create table Cart_Details(
CartID int,
ProductID int,
Quantity int,
Price float NOT NULL,
Primary key(CartID,ProductID),
Foreign key (CartID) references Cart (CartID) on delete cascade on update cascade,
Foreign key (ProductID) references Product (ProductID) on delete cascade on update cascade
);

Create table Review(
CustomerID int,
ProductID int,
Description varchar(300) NOT NULL,
Rating float ,
Date date NOT NULL,
Primary key(ProductID,CustomerID),
foreign key (ProductID) references Product (ProductID) on delete cascade on update cascade,
Foreign key (CustomerID) references Customer (CustomerID) on delete cascade on update cascade
);

Create table Orders(
CustomerID int ,
OrderID int identity(500,1),
ShippingAdress varchar(300) NOT NULL,
DatePlaced date NOT NULL,
ShippingDate date NOT NULL,
TotalPrice float NOT NULL default(0),
Discount float NOT NULL default(0),
Status varchar(50) NOT NULL,
Primary key(OrderID),
Foreign key (CustomerID) references Customer (CustomerID) on delete cascade on update cascade,
);

Create table Order_Details(
ProductID int,
OrderID int,
Price float NOT NULL default(0),
Quantity int NOT NULL,
Primary key(OrderID,ProductID),
Foreign key (OrderID) references Orders(OrderID) on delete cascade on update cascade,
Foreign key (ProductID) references Product(ProductID) on delete cascade on update cascade
);

Create table Payment(
CustomerID int,
OrderID int,
PaymentID int identity(600,1),
TotalPrice float NOT NULL default(0),
PaymentMethod varchar(50),
DatePaid date,
Status varchar(20) NOT NULL default('Unpaid'),
Primary key(PaymentID),
foreign key (OrderID) references Orders (OrderID) on delete cascade on update cascade,
Foreign key (CustomerID) references Customer (CustomerID)
);

-- Insert values into Category table
INSERT INTO Category (CategoryName)
VALUES 
('Laptops'),
('Smartphones'),
('Tablets'),
('Headphones'),
('Cameras'),
('Monitors'),
('Smartwatches'),
('Gaming Consoles'),
('Audio Equipment'),
('Storage Devices');

-- Insert values into Product table
INSERT INTO Product (CategoryID, ProductName, Price, Discount, QuantityInStock, Description, Rating)
VALUES
(300, 'Dell XPS 15', 1500.00, 0.10, 50, 'Powerful laptop with stunning display', 0),
(300, 'MacBook Pro', 1800.00, 0.05, 30, 'Sleek design and exceptional performance', 0),
(301, 'iPhone 13 Pro', 999.00, 0.00, 100, 'Latest iPhone with advanced features', 0),
(301, 'Samsung Galaxy S21', 899.00, 0.15, 80, 'Flagship smartphone with stunning camera', 0),
(302, 'iPad Air', 599.00, 0.10, 60, 'Thin and light tablet with powerful performance', 0),
(303, 'Sony WH-1000XM4', 349.00, 0.05, 120, 'Wireless noise-canceling headphones', 0),
(303, 'Apple AirPods Pro', 249.00, 0.00, 150, 'True wireless earbuds with active noise cancellation', 0),
(304, 'Canon EOS R5', 3799.00, 0.20, 25, 'High-resolution mirrorless camera for professionals', 0),
(300, 'HP Pavilion 27-inch Monitor', 299.99, 0.05, 40, 'IPS display for vivid colors and wide viewing angles', 0),
(300, 'Dell UltraSharp 34 Curved Monitor', 999.99, 0.10, 20, 'Immersive curved display for enhanced productivity', 0),
(306, 'Apple Watch Series 7', 399.00, 0.00, 80, 'Advanced smartwatch with health monitoring features', 0),
(306, 'Samsung Galaxy Watch 4', 249.99, 0.10, 60, 'Smartwatch with ECG and blood pressure monitoring', 0),
(307, 'PlayStation 5', 499.99, 0.00, 100, 'Next-gen gaming console with high-performance graphics', 0),
(307, 'Xbox Series X', 499.99, 0.00, 90, 'Powerful gaming console for immersive gaming experience', 0),
(308, 'Bose SoundLink Revolve+', 299.99, 0.00, 50, 'Portable Bluetooth speaker with 360-degree sound', 0),
(303, 'Sony WH-CH710N Wireless Headphones', 199.99, 0.05, 80, 'Wireless headphones with noise cancellation', 0),
(308, 'Sonos Beam Smart Soundbar', 399.99, 0.10, 30, 'Smart soundbar for TV and music streaming', 0),
(309, 'Samsung T7 Portable SSD 1TB', 149.99, 0.00, 100, 'Fast and reliable portable SSD for data storage', 0),
(309, 'Seagate Backup Plus Hub 8TB External Hard Drive', 199.99, 0.10, 60, 'External hard drive with built-in USB hub', 0),
(309, 'SanDisk Ultra 128GB microSDXC Memory Card', 29.99, 0.00, 200, 'High-capacity microSDXC card for mobile devices', 0);

-- Insert values into USER table
INSERT INTO Customer (Name, PhoneNumber, Email, Password, Country, DateJoined)
VALUES
('John Doe', '1234567890', 'john.doe@gmail.com', 'S,8Zd2?A3-4', 'USA', '2024-03-19'),
('Alice Smith', '9876543210', 'alice.smith@gmail.com', '39}7|l2Adr@', 'UK', '2024-02-02'),
('Bob Johnson', '5551234567', 'bob.johnson@gmail.com', 'J5,f05?&X', 'Canada', '2024-04-01'),
('Emily Brown', '1231231234', 'emily.brown@gmail.com', '?23e|49LUyJ', 'USA', '2024-01-20'),
('Michael Wilson', '4564564567', 'michael.wilson@gmail.com', '0?N+0!)ow4', 'Canada', '2024-02-25'),
('Sophia Martinez', '7897897890', 'sophia.martinez@gmail.com', 'g,:hJ>4h40?', 'Australia', '2024-03-05'),
('David Wilson', '1112223333', 'david.wilson@gmail.com', 'cR3U_4C;8R9', 'USA', '2024-04-06'),
('Emma Taylor', '4445556666', 'emma.taylor@gmail.com', 'XL8Z01d(as;', 'UK', '2024-02-28'),
('James Brown', '7778889999', 'james.brown@gmail.com', 'Q68xT?6@t1BH', 'Australia', '2024-04-09'),
('Sandy ELZein', '2345789209', 'sandyelzein.@gmail.com', 'S,8Zd2?B8-4', 'Lebanon', '2024-04-19'),
('Amani Merhi', '2637271939', 'amanimerhi@gmail.com', 'Hj#d2?A3-4', 'Lebanon', '2024-04-22');

-- Insert values into ADMIN table
INSERT INTO ADMIN (Name, PhoneNumber, Email, Password, Country, Role, StartDate)
VALUES
('Lynn Noureddine', '76760536', 'lynn@gmail.com', '84:s2;;WKkPl', 'Lebanon', 'Admin', '2023-1-01'),
('Farah Hamze', '71611187', 'farah@hotmail.com', 'l!56Y;/~_f4]', 'Lebanon', 'Admin', '2023-1-01');

INSERT INTO Cart (CustomerID)
VALUES
(200),
(201),
(202),
(203),
(204),
(205),
(206),
(207),
(208),
(209),
(210);

INSERT INTO Cart_Details(CartID,ProductID,Quantity,Price)
VALUES
(400,2,1,0),
(401,5,1,0),
(402,2,1,0),
(403,5,3,0),
(404,2,1,0),
(405,9,2,0),
(406,13,1,0),
(407,20,10,0),
(408,3,3,0);

Update Cart_Details
Set Cart_Details.Price= Product.Price - (Product.Price * Product.Discount)
From Cart_Details 
Inner Join Product 
On Cart_Details.ProductID=Product.ProductID;

UPDATE Cart
SET TotalPrice = (
    SELECT SUM(CD.Quantity * CD.Price)
    FROM Cart_Details as CD
    WHERE CD.CartID = Cart.CartID
)
WHERE EXISTS (
    SELECT 1
    FROM Cart_Details as CD
    WHERE CD.CartID = Cart.CartID
);

INSERT INTO Orders (CustomerID, ShippingAdress, DatePlaced, ShippingDate, Status)
VALUES
(200, '123 Main St, New York, NY','2024-04-16', '2024-04-17', 'Processing'),
(201, '456 Elm St, London, UK','2024-04-16', '2024-04-17', 'Processing'),
(202, '789 Oak St, Toronto, Canada','2024-04-16', '2024-04-17', 'Processing'),
(203, '123 Pine St, Los Angeles, CA', '2024-04-17', '2024-04-18', 'Processing'),
(204, '456 Maple St, Vancouver, BC', '2024-04-17', '2024-04-18', 'Processing'),
(205, '789 Cedar St, Sydney, NSW', '2024-04-17', '2024-04-18', 'Processing'),
(206, '123 Oak St, Chicago, IL', '2024-04-18', '2024-04-19', 'Processing'),
(207, '456 Walnut St, Manchester, UK','2024-04-18', '2024-04-19', 'Processing'),
(208, '789 Cedar St, Melbourne, VIC','2024-04-18', '2024-04-19', 'Processing'),
(209, 'Beirut','2024-04-18', '2024-04-19', 'Processing'),
(209, 'Beirut','2024-04-18', '2024-04-19', 'Processing'),
(210, 'Beirut','2024-04-18', '2024-04-19', 'Processing');

-- Insert values into Order_Details table
INSERT INTO Order_Details (ProductID, OrderID, Quantity)
VALUES
(2, 500, 1),
(3, 500, 30),
(4, 501, 1),
(7, 502, 1),
(13, 503, 1),
(5, 504, 1),
(14, 505, 1),
(16, 506, 1),
(17, 507, 1),
(2, 508, 1),
(16, 508, 2),
(12, 510, 1),
(15, 511, 2);

Update Order_Details
Set Order_Details.Price=Product.Price- (Product.Price * Product.Discount)
From Order_Details 
Inner Join Product 
On Order_Details.ProductID=Product.ProductID;

UPDATE Orders
SET TotalPrice = (
    SELECT SUM(OD.Quantity * OD.Price)
    FROM Order_Details as OD
    WHERE OD.OrderID = Orders.OrderID
)
WHERE EXISTS (
    SELECT 1
    FROM Order_Details as OD
    WHERE OD.OrderID = Orders.OrderID
);

-- Insert values into Review table
INSERT INTO Review (CustomerID, ProductID, Description, Rating, Date)
VALUES
(200, 2, 'Great laptop, excellent performance!', 5, '2024-04-16'),
(201, 4, 'Amazing phone, love the camera quality!', 4.7, '2024-04-16'),
(202, 7, 'Best headphones I ever had, noise cancellation works great!', 3.2, '2024-04-16'),
(203, 13, 'Amazing watch, great for work!', 4, '2024-04-17'),
(200, 3, 'Fantastic Macbook, love the user interface.', 5, '2024-04-17'),
(205, 14, 'Excellent performance, highly recommended!', 4, '2024-04-18'),
(206, 16, 'Great headphones, comfortable for long use.', 4, '2024-04-18'),
(207, 17, 'Impressive headphones, enhances listening experience.', 5, '2024-04-18');

Update Product
Set Rating = (
    Select Avg(R.Rating)
    From Review as R
    Where R.ProductID = Product.ProductID
)
Where Exists (
    Select 1
    From Review as R
    Where R.ProductID = Product.ProductID
);

-- Insert values into Payment table
INSERT INTO Payment (CustomerID, OrderID)
VALUES
(200, 500),
(201,501),
(202,502),
(203,503),
(204,504),
(206,506),
(207,507),
(208,508),
(209,509),
(209,510),
(210,511);

Update Payment
Set Payment.TotalPrice=Orders.TotalPrice - (Orders.TotalPrice * Orders.Discount)
From Payment 
Inner Join Orders 
On Payment.OrderID=Orders.OrderID;

-- Update the status of the orders that are to be shipped 
Update orders
Set Status = 'Shipped'
Where ShippingDate = '2024-04-17';

-- Update the status of the orders that have been recieved
Update orders
Set Status = 'Recieved'
Where OrderID IN (500, 501, 502);

-- Update the status of the payments that have been paid
Update Payment
Set Status = 'Paid'
Where OrderID IN (500, 501, 502);

--1 Display all orders while displaying total price and total quantity.
select O.OrderID, C.Name, O.DatePlaced, O.ShippingAdress, O.ShippingDate, O.Status, O.TotalPrice, sum(OD.Quantity) as 'Total Quantity' from Orders as O
join Order_Details as OD On O.OrderID=OD.OrderID
join Product as P On OD.ProductID=P.ProductID
join Customer as C On O.CustomerID=C.CustomerID
group by O.OrderID, C.Name, O.DatePlaced, O.ShippingAdress, O.ShippingDate, O.Status, O.TotalPrice;

--2 Display orders with total price > $2000 
select O.OrderID, C.Name, O.TotalPrice from Orders as O
join Order_Details as OD On O.OrderID=OD.OrderID
join Product as P On OD.ProductID=P.ProductID
join Customer as C On O.CustomerID=C.CustomerID
group by O.OrderID,C.Name
having O.TotalPrice>2000;

--3 Orders placed on a certain day eg('2024-04-17')
select O.OrderID, C.Name, O.DatePlaced, O.ShippingAdress, O.ShippingDate, O.Status, O.TotalPrice,sum(OD.Quantity) as 'Total Quantity' from Orders as O
	join Order_Details as OD On O.OrderID=OD.OrderID
	join Product as P On OD.ProductID=P.ProductID
	join Customer as C On O.CustomerID=C.CustomerID
where O.DatePlaced = '2024-04-17'
group by O.OrderID, C.Name, O.DatePlaced, O.ShippingAdress, O.ShippingDate, O.Status, O.TotalPrice;

--4 total number of orders per day
select O.DatePlaced ,Count(*) as 'No of Orders Placed' from Orders as O
group by O.DatePlaced;

--5 Average No of orders per day 
select AVG(order_count) as 'Average No of Orders Per Day'
from (
    select Count(*) AS order_count
    from Orders
    group by DatePlaced
) as order_count;

--6 No of times the product was ordered
select P.ProductName, MAX(order_count) as 'No of orders'
from ( 
    select P.ProductID,Count(P.ProductID) as order_count
	from Orders as O
	join Order_Details as OD On O.OrderID=OD.OrderID
	join Product as P On P.ProductID=OD.ProductID 
	group by P.ProductID 
)as order_count
join Product as P On P.ProductID=order_count.ProductID
group by P.ProductName;

--7 Most Ordered Product
select P.ProductName, MAX(order_count) as 'Most Ordered Product'
from (
    select P.ProductID, Count(P.ProductID) as order_count
    from Orders as O
    JOIN Order_Details as OD On O.OrderID = OD.OrderID
    JOIN Product as P On P.ProductID = OD.ProductID 
    group by P.ProductID
) as order_counts
join Product as P On P.ProductID = order_counts.ProductID
where order_count = (
    select MAX(order_count)
    from (
        select Count(P.ProductID) as order_count
        from Orders as O
        join Order_Details as OD On O.OrderID = OD.OrderID
        join Product as P On P.ProductID = OD.ProductID 
        group by P.ProductID
    ) as max_order_count
)
group by P.ProductName;

--8 Display the details of the products inside the cart of a certain customer 
select P.ProductName, CD.Quantity, CD.Price from Cart as C
join Cart_Details as CD On CD.CartID = C.CartID 
join Product as P On P.ProductID = CD.ProductID
where C.CustomerID = '205'

--9 Display a certain customer's order history
select C.Name, O.OrderID, O.ShippingAdress, O.DatePlaced, O.ShippingDate, O.Status, P.ProductName, OD.Quantity, Sum(OD.Price-(OD.Price*O.Discount)) as 'Price' from  orders as O 
join Order_Details as OD On O.OrderID=OD.OrderID
join Customer as C On O.CustomerID=C.CustomerID
join Product as P On P.ProductID=OD.ProductID
where C.CustomerID='202'
group by C.Name, O.OrderID, O.ShippingAdress, O.DatePlaced, O.ShippingDate, O.Status, P.ProductName, OD.Quantity;

--10 Customer wants to delete their order
Update Orders
Set Status = 'Canceled'
where OrderID = '505'

--11 List all unpaid orders
select* from Payment
where Status = 'Unpaid'

--12 List the date with the most orders
select top 1 DatePlaced, Count(*) as 'Number of orders' from Orders as O
group by DatePlaced
order by DatePlaced Desc;

--13 List the user with the most order
select top 1 C.Name, Count(*) as 'Number of orders' from Orders as O
Join Customer as C On O.CustomerID = C.CustomerID
group by C.Name
order by 'Number of orders' Desc;

--14 List the products that have not been orderd
select P.* from Product as P
where P.ProductID NOT IN(
	Select OD.ProductID from Order_Details as OD
	join Orders as O On O.OrderID = OD.OrderID
);

--15 List the country with the most orders
select top 1 C.Country, Count(*) as 'Total number of orders' from Orders as O
join Customer as C On C.CustomerID = O.CustomerID
group by C.Country
order by 'Total number of orders' Desc;

SELECT C.Country, COUNT(*) as [Total number of orders]
FROM Orders AS O
JOIN Customer AS C ON C.CustomerID = O.CustomerID
GROUP BY C.Country
HAVING COUNT(*) = (
    SELECT TOP 1 COUNT(*)
    FROM Orders AS O2
    JOIN Customer AS C2 ON C2.CustomerID = O2.CustomerID
    GROUP BY C2.Country
    ORDER BY COUNT(*) DESC
)
ORDER BY [Total number of orders] DESC;

--16 List the total revenue of each category
select C.CategoryName, Sum(PY.TotalPrice) as 'Total Revenue' from Category as C
join Product as P On P.CategoryID = C.CategoryID
join Order_Details as OD On OD.ProductID = P.ProductID
join Orders as O On O.OrderID = OD.OrderID
join Payment as PY On PY.OrderID = O.OrderID
where PY.Status = 'Paid'
group by C.CategoryName;

--17 Number of items purchased per day
select O.DatePlaced, Sum(OD.Quantity) as 'Total items purchased' from Orders O
join Order_Details OD On OD.OrderID = O.OrderID
join Product P On P.ProductID = OD.ProductID
group by O.DatePlaced;

--18 List the average quantity order per product
select P.ProductName, Avg(OD.Quantity) as 'Average qauntity ordered' from Product as P
join Order_Details as OD on OD.ProductID = P.ProductID
join Orders as O On O.OrderID = OD.OrderID
group by P.ProductName;

--19 List the customers that have more than 2 orders 
select C.Name, Count(*) as 'Number of orders' from Orders as O
join Customer as C On C.CustomerID = O.CustomerID
group by C.Name, C.CustomerID
having Count(*) > 2;

--20 Customer wants to modify cart (delete an item)
delete from Cart_Details
where CartID = ''
and ProductID = '';

--21 Display the total price of a customer's cart
select TotalPrice from Cart
where CustomerID = '205';

--22 List the average rating of every products
select P.ProductName, Avg(R.Rating) as 'Average Rating' from Product as P
join Review as R On P.ProductID = R.ProductID
group by P.ProductName;

--23 List the orders with more then 10 items (total quantity > 10)
select O.OrderID, Sum(OD.Quantity) as 'Total Qauntity' from Orders as O
join Order_Details as OD On OD.OrderID = O.OrderID
group by O.OrderID
having Sum(OD.Quantity) > 10;

--20% discount for all order with total quantity > 10
Update Orders 
Set Discount = 20,
TotalPrice = (
	Select Sum(OD.Price * OD.Quantity - OD.Price * 0.2) 
	From Order_Details as OD
	Where OD.OrderID = Orders.OrderID
	Group by OD.OrderID
	Having Sum(OD.Quantity) > 10
)
where Exists(
	select 1
    from Order_Details as OD
    where OD.OrderID = Orders.OrderID
);

--24 Number of orders being shipped to a specific country 
select C.Country, Count(O.OrderID) as 'Number of orders shipped' from Orders O
join Customer C On C.CustomerID = O.CustomerID
where O.Status = 'Shipped'
and C.Country = 'USA'
group by C.Country

--25 Total profit generated so far
select Sum(P.TotalPrice) as 'Total profit generated so far' from Payment P
where P.Status = 'Paid';

--26 Display total number of customers
select COUNT(*) as TotalNoOfCustomers
from Customer;

--27 List all products of a specific category
select P.* from Product P
join Category C On C.CategoryID = P.CategoryID
where C.CategoryName = 'Laptops'

--28 List the customers that ordered a specific product
select C.Name, O.OrderID from Orders O
join Customer C On C.CustomerID = O.CustomerID
join Order_Details OD On OD.OrderID = O.OrderID
join Product P On P.ProductID = OD.ProductID
where P.ProductName = 'MacBook Pro';

--29 Display list of customers who canceled orders
select C.* from Customer as C 
where C.CustomerID In(
	select O.CustomerID
	from Orders as O
	where O.Status ='Canceled');

--30 Display list of reviews for a specific product (with customer name)
select P.ProductName, C.Name, R.Description, R.Rating, R.Date as CustomerName
from Review r
join Customer as C On R.CustomerID = C.CustomerID
join Product P On P.ProductID = R.ProductID
where r.ProductID = '4';

--31 Display the list of shipped orders on a specific date ex('2024-04-17')
select * from orders as O 
where O.Status ='Shipped'
and O.ShippingDate='2024-04-18';

--32 Display top selling categories
select C.CategoryName, SUM(OD.Quantity) as TotalQuantitySold
from Product as P
join Order_Details as OD On P.ProductID = OD.ProductID
join Category as C On P.CategoryID = C.CategoryID
group by C.CategoryName
Order by TotalQuantitySold DESC;

--33 Display average number of products per order
select AVG(Quantity) as AverageNoOfProductsPerOrder
from Order_Details;

--34 Display average number of orders per customer
 select customerID, avg(NumOrders) as AverageNumberOfOrdersPerCustomer
from (
    select customerID, count(OrderID) as NumOrders
    from orders
    group by customerID
) as ordercount
group by customerID;

--35 Total income per category
select C.CategoryName, SUM(PY.TotalPrice) as TotalIncome
from Product as P
join Order_Details as OD On P.ProductID = OD.ProductID
join Orders as O On O.OrderID = OD.OrderID
join Category as C On P.CategoryID = C.CategoryID
join Payment PY On PY.OrderID = O.OrderID
where PY.Status = 'Paid'
group by C.CategoryName;

--36 Display all paid payments where the payment method was cash on delivery
select * from Payment as P 
where P.PaymentMethod = 'Cash on delivery';

--37 Display the day with the highest total order value
select DayWithHighestTotalOrderValue, TotalOrderValue
from (
	select O.DatePlaced AS DayWithHighestTotalOrderValue, SUM(O.TotalPrice) AS TotalOrderValue
	from Orders as O
	join Order_Details as OD On O.OrderID = OD.OrderID
group by O.DatePlaced) as order_value
where TotalOrderValue = (
	select MAX(TotalOrderValue)
	from (
        select SUM(O.TotalPrice) as TotalOrderValue
        from Orders as O
        join Order_Details as OD On O.OrderID = OD.OrderID
        group by O.DatePlaced
    )as max_order_value
);

--38 Display the country with the highest total order value
select C.Country, SUM(O.TotalPrice) as TotalOrderValue
from Orders as O
	join Order_Details as OD On O.OrderID = OD.OrderID
	join Customer as C On O.CustomerID = C.CustomerID
group by C.Country
having SUM(O.TotalPrice) = (
	select MAX(TotalOrderValue)
	from (
        select SUM(O.TotalPrice) as TotalOrderValue
        from Orders as O
        join Order_Details as OD On O.OrderID = OD.OrderID
        join Customer as C On O.CustomerID = C.CustomerID
        group by C.Country
    )as max_order_value
); 

--39 Display the information of the customer who placed the most orders
select C.*,order_count.order_count
from Customer C
join (
    select CustomerID, COUNT(*) as order_count
    from Orders
    group by CustomerID
) order_count On C.CustomerID = order_count.CustomerID
where order_count.order_count = (
    select MAX(OrderCount)
    from (
        select COUNT(*) as OrderCount
        from Orders
        group by CustomerID
    ) as max_order_count
);

--40 List the products whose price is less than a specified amount
select P.* from Product P
where Price < 1000;

--41 List the products from highest rating to lowest
select* from Product
order by Rating Desc

--42 List all the customers from a specific country
select* from Customer
where Country = 'Lebanon';

--43 List the number of customers per country 
select Country, Count(CustomerID) AS 'Customer Count 'from Customer
group by Country;

--
--47 Display orders that include products with a rating above 4
select O.OrderID, OD.ProductID, P.ProductName, P.Rating
from Orders as O
	join Order_Details as OD On O.OrderID=OD.OrderID
	join Product as P On P.ProductID=OD.ProductID
where P.Rating > 4.0;

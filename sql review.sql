CREATE TABLE Products (
    ProductID int NOT NULL,
    ProductName varchar(255) NOT NULL,
	seller varchar(20),
	ProductType varchar(20),
    PRIMARY KEY (ProductID)
);

drop table Products;
select * from Products;


CREATE TABLE Orders (
    OrderID int NOT NULL,
    ProductID int NOT NULL,
    Quantity int,
    price int,
    purchaseDate date,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

select * from Orders;

Insert into Products(ProductID,ProductName,seller,ProductType) values(101,'Mobile','Amazon','Electronics');
Insert into Products(ProductID,ProductName,seller,ProductType) values(102,'Tshits','Amazon','Clothing');
Insert into Products(ProductID,ProductName,seller,ProductType) values(103,'Jackets','Flipkart','Clothing');
Insert into Products(ProductID,ProductName,seller,ProductType) values(104,'FLower Vase','Flipkart','Home Decor');
Insert into Products(ProductID,ProductName,seller,ProductType) values(105,'HeadPhones','Amazon','Electronics');
Insert into Products(ProductID,ProductName,seller,ProductType) values(106,'Photo Frames','Flipkart','Home Decor');


Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(1,105,20,1000,'02-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(2,102,25,300,'02-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(3,104,5,500,'05-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(4,104,7,500,'08-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(5,106,8,200,'05-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(6,101,15,5000,'08-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(7,103,20,800,'04-08-2024');
Insert into orders(OrderID,ProductID,Quantity,price,purchaseDate) values(8,105,5,1000,'04-08-2024');

-- return product purchased on given date
SELECT P.ProductName
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE O.purchaseDate = '05-08-2024';

-- no of product purchased on particular date
Select count(ProductId) from Orders where purchaseDate ='08-08-2024';

 -- max price product on particular date
SELECT P.ProductName, O.price
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE O.purchaseDate = '2024-08-02' AND O.price = (
    SELECT MAX(price)
    FROM Orders
    WHERE purchaseDate = '2024-08-02'
);

-- Extra- write a function return the total business that took place on the particular date
CREATE OR REPLACE FUNCTION total_business_on_date(input_date date)
RETURNS decimal AS $$
DECLARE
    total_sales decimal;
BEGIN
    SELECT SUM(O.price * O.Quantity) INTO total_sales
    FROM Orders O
    WHERE O.purchaseDate = input_date;

    RETURN total_sales;
END; $$
LANGUAGE plpgsql;

SELECT total_business_on_date('2024-08-02');
SELECT total_business_on_date('2024-08-08');
SELECT total_business_on_date('2024-08-05');
SELECT total_business_on_date('2024-08-04');






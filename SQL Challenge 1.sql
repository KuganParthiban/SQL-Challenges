CREATE DATABASE SQL_Challenge_1;
USE SQL_Challenge_1

CREATE TABLE cars (
car_id INT PRIMARY KEY,
make VARCHAR(50),
type VARCHAR(50),
style VARCHAR(50),
cost_$ INT
);
--------------------
INSERT INTO cars (car_id, make, type, style, cost_$)
VALUES (1, 'Honda', 'Civic', 'Sedan', 30000),
(2, 'Toyota', 'Corolla', 'Hatchback', 25000),
(3, 'Ford', 'Explorer', 'SUV', 40000),
(4, 'Chevrolet', 'Camaro', 'Coupe', 36000),
(5, 'BMW', 'X5', 'SUV', 55000),
(6, 'Audi', 'A4', 'Sedan', 48000),
(7, 'Mercedes', 'C-Class', 'Coupe', 60000),
(8, 'Nissan', 'Altima', 'Sedan', 26000);
--------------------
CREATE TABLE salespersons (
salesman_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
city VARCHAR(50)
);
--------------------
INSERT INTO salespersons (salesman_id, name, age, city)
VALUES (1, 'John Smith', 28, 'New York'),
(2, 'Emily Wong', 35, 'San Fran'),
(3, 'Tom Lee', 42, 'Seattle'),
(4, 'Lucy Chen', 31, 'LA');
--------------------
CREATE TABLE sales (
sale_id INT PRIMARY KEY,
car_id INT,
salesman_id INT,
purchase_date DATE,
FOREIGN KEY (car_id) REFERENCES cars(car_id),
FOREIGN KEY (salesman_id) REFERENCES salespersons(salesman_id)
);
--------------------
INSERT INTO sales (sale_id, car_id, salesman_id, purchase_date)
VALUES (1, 1, 1, '2021-01-01'),
(2, 3, 3, '2021-02-03'),
(3, 2, 2, '2021-02-10'),
(4, 5, 4, '2021-03-01'),
(5, 8, 1, '2021-04-02'),
(6, 2, 1, '2021-05-05'),
(7, 4, 2, '2021-06-07'),
(8, 5, 3, '2021-07-09'),
(9, 2, 4, '2022-01-01'),
(10, 1, 3, '2022-02-03'),
(11, 8, 2, '2022-02-10'),
(12, 7, 2, '2022-03-01'),
(13, 5, 3, '2022-04-02'),
(14, 3, 1, '2022-05-05'),
(15, 5, 4, '2022-06-07'),
(16, 1, 2, '2022-07-09'),
(17, 2, 3, '2023-01-01'),
(18, 6, 3, '2023-02-03'),
(19, 7, 1, '2023-02-10'),
(20, 4, 4, '2023-03-01');

--1. What are the details of all cars purchased in the year 2022?

SELECT sales.sale_id, sales.purchase_date, cars.make, cars.style, cars.type, cars.cost_$
FROM sales
JOIN cars ON sales.car_id=cars.car_id
WHERE YEAR(sales.purchase_date) = 2022;

--2. What is the total number of cars sold by each salesperson?
SELECT salespersons.name , COUNT(sales.sale_id) AS TotalCarsSold
FROM sales
JOIN salespersons ON sales.salesman_id = salespersons.salesman_id
GROUP BY salespersons.name;

--3. What is the total revenue generated by each salesperson?
SELECT salespersons.salesman_id, salespersons.name, SUM(cars.cost_$) AS TotalRevenue
FROM sales
JOIN cars ON sales.car_id = cars.car_id
JOIN salespersons ON sales.salesman_id = salespersons.salesman_id
GROUP BY salespersons.salesman_id, salespersons.name;

--4. What are the details of the cars sold by each salesperson?

SELECT salespersons.name, cars.make, cars.style, cars.type, cars.cost_$
FROM sales
JOIN cars ON sales.car_id=cars.car_id
JOIN salespersons ON sales.salesman_id=salespersons.salesman_id

--5. What is the total revenue generated by each car type?
SELECT type, SUM(cars.cost_$) AS TotalRevenue
FROM cars
GROUP BY cars.type

--6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?
SELECT cars.make, cars.style, cars.type, cars.cost_$,sales.purchase_date, salespersons.salesman_id, salespersons.name
FROM sales
JOIN salespersons ON salespersons.salesman_id=sales.salesman_id
JOIN cars ON sales.car_id = cars.car_id
WHERE salespersons.name='Emily Wong' AND YEAR(sales.purchase_date) = 2021;

--7. What is the total revenue generated by the sales of hatchback cars?
SELECT SUM(cars.cost_$) AS TotalRevenue_Hatchback
FROM sales
JOIN cars ON sales.car_id=cars.car_id
WHERE cars.style = 'Hatchback'

--8. What is the total revenue generated by the sales of SUV cars in the year 2022?
SELECT SUM(cars.cost_$) AS TotalRevenue_SUV
FROM sales
JOIN cars ON sales.car_id=cars.car_id
WHERE cars.style='SUV' AND YEAR(sales.purchase_date) = 2022;

--9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?
SELECT TOP 1 salespersons.name, salespersons.city, COUNT(sales.sale_id) AS TotalSales
FROM sales
JOIN salespersons ON sales.salesman_id = salespersons.salesman_id
WHERE YEAR(sales.purchase_date) = 2023
GROUP BY salespersons.name, salespersons.city
ORDER BY TotalSales DESC

--10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?
SELECT TOP 1 salespersons.name, salespersons.age, SUM(cars.cost_$) AS HighestRevenue
FROM sales
JOIN cars ON sales.car_id=cars.car_id
JOIN salespersons ON sales.salesman_id=salespersons.salesman_id
WHERE YEAR(sales.purchase_date) = 2022
GROUP BY salespersons.name, salespersons.age
ORDER BY HighestRevenue DESC




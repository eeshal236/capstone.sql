CREATE TABLE IF NOT EXISTS sales_man(
salesman_id  TEXT PRIMARY KEY,
name TEXT,
city TEXT,
commission INTEGER
);

INSERT INTO sales_man(salesman_id, name, city, commission)
VALUES 
('5001', 'James Smith', 'New York', 0.15),
('5002', 'Michael Johnson', 'Florida', 0.13),
('5004', 'Robert Williams', 'San Francisco', 0.16),
('5005', 'John Miller', 'Portland', 0.11),
('5007', 'Joseph Wilson', 'Colorado', 0.13),
('5003', 'Daniel Garcia', 'San Francisco', 0.15);

CREATE TABLE IF NOT EXISTS customer(
customer_id  TEXT,
cust_name TEXT PRIMARY KEY,
city TEXT,
grade TEXT,
salesman_id TEXT
);

INSERT INTO customer(customer_id, cust_name, city, grade, salesman_id)
VALUES 
('3001', 'Alexander Mitchell', 'New York', 100, '5001'),
('3002', 'Thomas Anderson', 'Florida', 200, '5002'),
('3004', 'Jack Miller', 'San Francisco', 300, '5007'),
('3005', 'Max Turner', 'Paris', 400, '5003'),
('3007', 'Eli Sanders', 'Colorado', 200,'5004' ),
('3003', 'Zane Morgan', 'San Francisco', 200, '5005'),
('3008', 'Benjamin Hayes', 'New York', 100, '5002'),
('3006', 'George Marshal', 'San Francisco', 300, '5003');

CREATE TABLE IF NOT EXISTS orders(
order_no  TEXT PRIMARY KEY,
purch_amt TEXT ,
ord_date TEXT,
customer_id TEXT,
salesman_id TEXT
);

INSERT INTO orders(order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
('7001','150.5','2012-10-5','3001','5001'),
('7002','165.75','2012-9-10','3002','5002'),
('7004','65.26','2012-5-8','3006','5004'),
('7005','110.5','2012-6-5','3004','5006'),
('7003','948.5','2012-4-13','3003','5003'),
('7006','2004.6','2012-4-7','3005','5005');

SELECT customer.cust_name, sales_man.salesman_id, sales_man.city
FROM customer
JOIN sales_man ON customer.city = sales_man.city;

SELECT customer.cust_name, sales_man.name
FROM customer
JOIN sales_man ON customer.salesman_id = sales_man.salesman_id;

SELECT orders.order_no, customer.cust_name, orders.customer_id, orders.salesman_id
FROM orders
JOIN customer ON orders.customer_id = customer.customer_id
JOIN sales_man ON orders.salesman_id = sales_man.salesman_id;
    
SELECT orders.order_no, customer.cust_name, orders.customer_id, orders.salesman_id
FROM orders
JOIN customer ON orders.customer_id = customer.customer_id
JOIN sales_man ON orders.salesman_id = sales_man.salesman_id
WHERE customer.city <> sales_man.city;


SELECT orders.order_no, customer.cust_name
FROM orders
JOIN customer ON orders.customer_id = customer.customer_id;


SELECT customer.cust_name AS "Customer", customer.grade AS "Grade"
FROM orders
JOIN sales_man ON orders.salesman_id = sales_man.salesman_id
JOIN customer ON orders.customer_id = customer.customer_id
WHERE customer.grade IS NOT NULL;


SELECT customer.cust_name AS "customer",
customer.city AS "City",
sales_man.name AS "Salesman",
sales_man.commission
FROM customer
JOIN sales_man ON customer.salesman_id = sales_man.salesman_id
WHERE sales_man.commission BETWEEN 0.12 AND 0.14;


SELECT orders.order_no, customer.cust_name, sales_man.commission AS "Commission%",
orders.purch_amt * sales_man.commission AS "Commission"
FROM orders
JOIN sales_man ON orders.salesman_id = sales_man.salesman_id
JOIN customer ON orders.customer_id = customer.customer_id
WHERE customer.grade >= 200;


SELECT *
FROM customer
JOIN orders ON customer.customer_id = orders.customer_id
WHERE orders.ord_date = '2012-10-05';

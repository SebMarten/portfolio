-- Creating the sales representatives table
CREATE TABLE sales_reps (
    rep_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    region VARCHAR(255)
);
-- Creating the products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price NUMERIC(10, 2)
);
-- Creating the orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    rep_id INT REFERENCES sales_reps(rep_id),
    quantity INT,
    order_date DATE
);
--Populating 'sales_reps' table
INSERT INTO sales_reps (name, email, region) VALUES
('John Doe', 'johndoe@example.com', 'North'),
('Jane Smith', 'janesmith@example.com', 'South'),
('Emily Johnson', 'emilyjohnson@example.com', 'East'),
('Alex Brown', 'alexbrown@example.com', 'West'),
('Chris Davis', 'chrisdavis@example.com', 'North'),
('Patricia Miller', 'patriciamiller@example.com', 'South'),
('James Wilson', 'jameswilson@example.com', 'East');
--Populating 'products' table
INSERT INTO products (name, price) VALUES
('Laptop', 1200.00),
('Smartphone', 700.00),
('Tablet', 450.00),
('Desktop', 1100.00),
('Smartwatch', 250.00),
('E-Reader', 180.00),
('Headphones', 130.00);
--Populating 'orders' table
INSERT INTO orders (product_id, rep_id, quantity, order_date) VALUES
(1, 1, 2, '2023-01-15'),
(2, 2, 1, '2023-02-20'),
(3, 1, 3, '2023-03-05'),
(4, 3, 1, '2023-01-25'),
(5, 4, 2, '2023-02-15'),
(1, 5, 1, '2023-03-10'),
(2, 6, 2, '2023-01-30'),
(3, 7, 1, '2023-02-25'),
(4, 1, 1, '2023-03-15'),
(5, 2, 1, '2023-01-20'),
(6, 3, 2, '2023-02-10'),
(7, 4, 3, '2023-03-20');
--- Now I would like to adapt and explore this imaginary data using SQL --- 
-- 1. Insert data into the sales_reps table
-- This command adds a new sales representative to the sales_reps table.
INSERT INTO sales_reps (name, email, region) 
VALUES ('New Rep', 'newrep@example.com', 'Central');
-- 2. Update a product's price in the products table
-- Increases the price of the product with product_id = 1 by 10%
UPDATE products 
SET price = price * 1.1 
WHERE product_id = 1;
-- 3. Select all products cheaper than 500
-- Retrieves details of all products priced below 500
SELECT * FROM products 
WHERE price < 500;
-- 4. Calculate the total quantity of orders
-- Sums up the quantity of all orders placed
SELECT SUM(quantity) AS total_quantity 
FROM orders;
-- 5. List products with their orders
-- Shows all products and any orders associated with them using a LEFT JOIN
SELECT p.name, o.quantity, o.order_date 
FROM products AS p 
LEFT JOIN orders AS o 
ON p.product_id = o.product_id;
-- 6. Find sales reps who have made sales in the 'North' region
-- Selects sales representatives who have made at least one sale in the North region
SELECT DISTINCT s.name 
FROM sales_reps AS s 
JOIN orders AS o 
ON s.rep_id = o.rep_id 
WHERE s.region = 'North';
-- 7. Count the number of products sold by each sales rep
-- Groups orders by sales rep and counts the number of products they have sold
SELECT rep_id, COUNT(*) AS products_sold 
FROM orders 
GROUP BY rep_id;
-- 8. Update order quantity
-- Increases the quantity by 1 for orders placed on '2023-03-10'
UPDATE orders 
SET quantity = quantity + 1 
WHERE order_date = '2023-03-10';
-- 9. Delete orders with a specific product_id
-- Deletes all orders for the product with product_id = 7
DELETE FROM orders 
WHERE product_id = 7;
-- 10. List all sales reps along with the products they have sold and the quantity
-- Combines sales reps, products, and orders to display what each rep has sold
SELECT s.name, p.name AS product_name, o.quantity 
FROM sales_reps AS s 
JOIN orders AS o 
ON s.rep_id = o.rep_id 
JOIN products AS p 
ON o.product_id = p.product_id;
-- 11. Insert multiple orders
-- Adds multiple entries into the orders table at once
INSERT INTO orders (product_id, rep_id, quantity, order_date) 
VALUES (4, 2, 1, '2023-04-01'), (2, 3, 2, '2023-04-02');
-- 12. Retrieve orders made in March 2023
-- Selects orders placed in March 2023
SELECT * FROM orders 
WHERE order_date 
BETWEEN '2023-03-01' 
AND '2023-03-31';
-- 13. Show total sales (quantity) per product
-- Calculates the total quantity sold for each product
SELECT product_id, SUM(quantity) AS total_sales 
FROM orders 
GROUP BY product_id;
-- 14. Update sales_rep email
-- Changes the email of the sales rep with rep_id = 1
UPDATE sales_reps 
SET email = 'updatedemail@example.com' 
WHERE rep_id = 1;
-- 15. Select products not yet ordered
-- Finds products that have never been ordered using a LEFT JOIN and IS NULL
SELECT p.name 
FROM products AS p 
LEFT JOIN orders AS o 
ON p.product_id = o.product_id 
WHERE o.order_id IS NULL;
-- 16. List sales reps and their total sales in descending order
-- Orders sales reps by their total quantity of sales, from highest to lowest
SELECT s.rep_id, s.name, SUM(o.quantity) AS total_sales 
FROM sales_reps s 
JOIN orders o 
ON s.rep_id = o.rep_id 
GROUP BY s.rep_id 
ORDER BY total_sales DESC;
-- 17. Delete sales reps with no orders
-- Removes sales reps who have not made any sales (assuming a rep_id that does not exist in orders)
DELETE FROM sales_reps 
WHERE rep_id NOT IN (SELECT DISTINCT rep_id FROM orders);
-- 18. Show average product price
-- Calculates the average price of all products from the products table
SELECT AVG(price) AS average_product_price 
FROM products;
-- 19. Select the most recent order for each product
-- Finds the most recent order date for each product
SELECT product_id, MAX(order_date) AS latest_order_date 
FROM orders 
GROUP BY product_id;
-- 20. Delete all data from orders, products, and sales_reps tables (in the correct order due to foreign key constraints)
-- Cleans up the database by removing all entries from the tables
DELETE FROM orders;
DELETE FROM products;
DELETE FROM sales_reps;
-- Finally, drop all tables to clean up the database
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales_reps;

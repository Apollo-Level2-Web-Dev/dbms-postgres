-- Active: 1747459510114@@localhost@5432@ph

CREATE Table orders(
order_id SERIAL PRIMARY KEY,
customer_id INTEGER,
order_date DATE,
total_amount DECIMAL(10,2)
)

INSERT INTO orders(customer_id, order_date, total_amount) VALUES
(101, '2025-05-01', 199.99),
(102, '2025-05-02', 89.50),
(103, '2025-05-03', 145.00),
(104, '2025-05-04', 320.75),
(101, '2025-05-05', 25.99),
(105, '2025-05-06', 470.00),
(102, '2025-05-07', 129.49),
(106, '2025-05-08', 250.00),
(107, '2025-05-09', 78.90),
(108, '2025-05-10', 199.00),
(102, '2024-03-07', 129.49),
(106, '2024-02-08', 250.00),
(107, '2024-01-09', 78.90),
(108, '2024-06-10', 199.00);

-- Find customers who have placed more than 2 orders and calculate the total amount spent by each of these customers.

SELECT customer_id, count(*) as order_qty, sum(total_amount) from orders
GROUP BY customer_id
HAVING count(order_id) >2;

-- Find the total amount of orders placed each month in the year 2025.

SELECT extract(month from order_date) as all_months, count(*) as order_qty FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2025
GROUP BY all_months 


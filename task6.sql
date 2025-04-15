CREATE DATABASE sales_analysis;
USE sales_analysis;
CREATE TABLE online_sales (
order_id INT,
order_date DATE,
amount DECIMAL (10,2),
product_id INT
);
SELECT * FROM online_sales;
SELECT
	EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
    
FROM
	online_sales
GROUP BY	
	order_year, order_month
ORDER BY
	order_year, order_month;
    SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    online_sales
WHERE 
    EXTRACT(YEAR FROM order_date) = 2023
GROUP BY 
    order_year, order_month
ORDER BY 
    order_year, order_month;

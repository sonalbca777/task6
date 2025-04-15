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



-- =============================================
-- Enhancement 1: Month-over-Month Revenue Growth
-- =============================================
WITH monthly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(amount) AS total_revenue
    FROM online_sales
    GROUP BY year, month
)
SELECT
    year,
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year, month) AS previous_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year, month)) * 100.0 /
        NULLIF(LAG(total_revenue) OVER (ORDER BY year, month), 0), 2
    ) AS revenue_growth_percentage
FROM monthly_revenue
ORDER BY year, month;

-- =============================================
-- Enhancement 2: Top Products by Revenue
-- =============================================
SELECT
    product_id,
    SUM(amount) AS revenue
FROM online_sales
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 5;

-- =============================================
-- Enhancement 3: Weekday Revenue Analysis
-- =============================================
SELECT
    TO_CHAR(order_date, 'Day') AS weekday,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY weekday
ORDER BY total_revenue DESC;

-- =============================================
-- Enhancement 4: Cumulative Revenue Over Time
-- =============================================
SELECT
    order_date,
    SUM(amount) OVER (ORDER BY order_date) AS cumulative_revenue
FROM online_sales
ORDER BY order_date;

-- =============================================
-- Optional: Filter by Time Period (example: last 6 months)
-- =============================================
SELECT
    *
FROM online_sales
WHERE order_date BETWEEN '2024-10-01' AND '2025-03-31';

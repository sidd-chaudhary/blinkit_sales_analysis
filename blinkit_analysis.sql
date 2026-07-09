SELECT * FROM blinkit_sales
LIMIT 10;

-- Q1 how much revenue did the company generate overall ?

SELECT SUM(sales) AS total_revenue
FROM blinkit_sales

-- Q2 which product categories contribute most of revenue ?

SELECT item_type,
SUM(sales) AS total_revenue
FROM blinkit_sales
GROUP BY item_type
ORDER BY total_revenue DESC;

-- Q3 which outlet type business model generates the highest revenue and show the amount of product sold ?


SELECT outlet_type,
ROUND(SUM(sales)::numeric, 2) AS total_revenue,
COUNT(*) AS total_product_sold
FROM
blinkit_sales
GROUP BY outlet_type
ORDER BY total_revenue DESC;

-- Q4 does outlet size affect sales? should blinkit invest more in larger stores ?

SELECT outlet_size,
ROUND(SUM(sales)::numeric,2) AS total_revenue,
ROUND(AVG(sales)::numeric,2) AS avg_revenue,
COUNT(*) AS total_products
FROM
blinkit_sales
GROUP BY outlet_size
ORDER BY total_revenue DESC;


-- Q5 which city tier contributes the most revenue ?

SELECT outlet_location_type,
SUM(sales) AS total_revenue
FROM
blinkit_sales
GROUP BY outlet_location_type
ORDER BY total_revenue DESC


-- Q6 which product categories are the top revenue generators ? find top 10 products by sales.

SELECT
item_type,
SUM(sales) AS total_revenue
FROM blinkit_sales
GROUP BY  item_type
ORDER BY total_revenue DESC
LIMIT 10;

-- Q7 which product categories have the highest average rating ?

SELECT
item_type,
AVG(rating) AS avg_review_rating
FROM
blinkit_sales
GROUP BY item_type
ORDER BY avg_review_rating DESC;


-- Q8 Does product visibility impact sales ?

SELECT 
CASE
WHEN item_visibility < 0.05 THEN'low visibility'
WHEN item_visibility BETWEEN 0.05 AND 0.15 THEN 'medium visibiliry'
ELSE 'high visibility'
END AS visibility_group,
ROUND(AVG(sales)::numeric, 2) AS avg_sales,
COUNT(*) AS total_products
FROM blinkit_sales
GROUP BY visibility_group
ORDER BY avg_sales DESC;

-- proudcts with medium visibility have the highest avg sales, while high visibility products have lowest avg sales,
-- this suggest that increasing product visibility alone does not lead to higher sales. other factor such as product,
-- category, pricing, and customer demand may have a great influence.

-- Q9 Does outlet age influence sales performance ? 

SELECT 
CASE
WHEN outlet_age <= 5 THEN 'New'
WHEN outlet_age BETWEEN 6 AND 10 THEN 'Growing'
ELSE 'Established'
END AS outlet_age_group,
ROUND(AVG(sales)::numeric,2) AS avg_sales,
ROUND(SUM(sales)::numeric,2) AS total_revenue,
COUNT(*) AS total_records
FROM
blinkit_sales
GROUP BY outlet_age_group
ORDER BY avg_sales DESC; -- business insights: new outlets have the highest avg sales per product. growing outlet generate highest revenue
                         -- due to having the largest number of products. overall, outlet age has only a minor impact on avg sales.


-- Q10 how do low fat and regular products compare in sales ?

SELECT item_fat_content,
ROUND(SUM(sales)::numeric,2) AS total_revenue,
ROUND(AVG(sales)::numeric,2) AS avg_sales,
COUNT(*) AS total_products
FROM
blinkit_sales
GROUP BY item_fat_content
ORDER BY total_revenue DESC; -- low fat contributte the highest total revenue due to a larger number of products. however, regular products have
                             -- a slightly higher avg sales value per product, indicating fat content has minimal impact on customer spending.


-- Q11 which outlet type receives the highest customer ratings ?

SELECT outlet_type,
ROUND(AVG(rating)::numeric,2) AS avg_review_rating,
COUNT(*) AS total_products
FROM blinkit_sales
GROUP BY outlet_type
ORDER BY avg_review_rating DESC;

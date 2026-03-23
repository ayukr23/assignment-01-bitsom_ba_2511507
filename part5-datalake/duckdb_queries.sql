SET FILE_SEARCH_PATH = 'C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake';
-- Q1: List all customers with total number of orders
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders
FROM
    read_csv_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\customers.csv') AS c
LEFT JOIN
    read_json_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.name, c.city
ORDER BY
    total_orders DESC;

    -- Q2: Find the top 3 customers by total order value
-- ============================================================
 
SELECT
    c.customer_id,
    c.name                          AS customer_name,
    c.city,
    COUNT(o.order_id)               AS total_orders,
    SUM(o.total_amount)             AS total_order_value
FROM
    read_csv_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\customers.csv')  AS c
JOIN
    read_json_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\orders.json')   AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name,
    c.city
ORDER BY
    total_order_value DESC
LIMIT 3;
 
 
-- ============================================================
-- Q3: List all products purchased by customers from Bangalore
-- ============================================================
 
SELECT DISTINCT
    c.customer_id,
    c.name                              AS customer_name,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price
FROM
    read_csv_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\customers.csv')      AS c
JOIN
    read_json_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\orders.json')       AS o
    ON c.customer_id = o.customer_id
JOIN
    read_parquet('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\products.parquet')    AS p
    ON o.order_id = p.order_id
WHERE
    c.city = 'Bangalore'
ORDER BY
    c.customer_id,
    p.product_name;
 
 
-- ============================================================
-- Q4: Join all three files — customer name, order date,
--     product name, and quantity
-- ============================================================
 
SELECT
    c.customer_id,
    c.name                              AS customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.status                            AS order_status,
    p.line_item_id,
    p.product_name,
    p.category,
    p.quantity,
    p.unit_price,
    p.total_price
FROM
    read_csv_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\customers.csv')      AS c
JOIN
    read_json_auto('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\orders.json')       AS o
    ON c.customer_id = o.customer_id
JOIN
    read_parquet('C:\Users\ayubi\Downloads\assignment-01-bitsom_ba_2511507\part5-datalake\products.parquet')    AS p
    ON o.order_id = p.order_id
ORDER BY
    o.order_date DESC,
    c.name;

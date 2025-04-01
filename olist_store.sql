# Olist E ecommerce analysis project 
Create database olist_store;
use olist_store;
select * from olist_orders_dataset;
select * from olist_order_reviews_dataset;
select * from olist_order_items_dataset;
select * from olist_order_payments_dataset;
select * from olist_products_dataset;
select * from olist_sellers_dataset;
select * from olist_customers_dataset;

# KPI 1: Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
Select * from olist_store.olist_orders_dataset;
Select * from olist_store.olist_order_payments_dataset;
SELECT 
    CASE 
        WHEN DAYOFWEEK(order_purchase_timestamp) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    COUNT(*) AS Order_Count,
    SUM(payment_value) AS Total_Payment,
    AVG(payment_value) AS Avg_Payment
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(order_purchase_timestamp) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END;


# KPI 2: Number of Orders with review score 5 and payment type as credit card

select * from olist_order_reviews_dataset;
SELECT 
    COUNT(*) AS Order_Count
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE r.review_score = 5 
  AND LOWER(p.payment_type) = 'credit_card';
  
# KPI 3: Average number of days taken for order_delivered_customer_date for pet_shop
    
SELECT 
round(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 0) AS avg_delivery_days
FROM 
olist_orders_dataset od
JOIN 
olist_order_items_dataset oi ON od.order_id = oi.order_id
JOIN 
olist_products_dataset op ON oi.product_id = op.product_id
WHERE 
op.product_category_name = 'pet_shop';
    
# KPI 4: Average price and payment values from customers of sao paulo city
SELECT 
    AVG(i.price) AS Avg_Price,
    AVG(p.payment_value) AS Avg_Payment
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE c.customer_city = 'São Paulo';
        

# KPI 5: Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
SELECT 
orr.review_score,
AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_shipping_days
FROM 
olist_orders_dataset od
JOIN 
olist_order_reviews_dataset orr ON od.order_id = orr.order_id
WHERE 
order_delivered_customer_date IS NOT NULL
GROUP BY 
orr.review_score;
  
  
SELECT 
COUNT(DISTINCT order_id) AS total_orders
FROM 
olist_orders_dataset;

SELECT 
SUM(payment_value) AS total_payment
FROM 
olist_order_payments_dataset;

SELECT 
COUNT(DISTINCT product_id) AS total_products
FROM 
olist_products_dataset;


SELECT 
SUM(oi.price - oi.freight_value) AS total_profit
FROM 
olist_order_items_dataset oi;

SELECT 
AVG(payment_value) AS avg_payment_value
FROM 
olist_order_payments_dataset;



 
 
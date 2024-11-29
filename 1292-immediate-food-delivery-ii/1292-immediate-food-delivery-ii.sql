# Write your MySQL query statement below
WITH FirstOrders AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
),
ImmediateOrders AS (
    SELECT d.customer_id, 
           CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END AS is_immediate
    FROM Delivery d
    JOIN FirstOrders f ON d.customer_id = f.customer_id
    WHERE d.order_date = f.first_order_date
)
SELECT 
    ROUND(AVG(is_immediate) * 100, 2) AS immediate_percentage
FROM ImmediateOrders;

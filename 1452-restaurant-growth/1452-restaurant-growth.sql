# Write your MySQL query statement below
WITH daily_sales AS (
    SELECT 
        visited_on, 
        SUM(amount) AS daily_total
    FROM Customer
    GROUP BY visited_on
),
windowed AS (
    SELECT 
        visited_on,
        SUM(daily_total) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
    FROM daily_sales
)
SELECT 
    visited_on,
    amount,
    ROUND(amount / 7, 2) AS average_amount
FROM windowed
WHERE rn >= 7
ORDER BY visited_on;
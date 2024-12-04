# Write your MySQL query statement below
WITH FirstLogin AS (
    -- Step 1: Get the first login date for each player
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
),
NextDayLogins AS (
    -- Step 2: Check if the player logged in the day after their first login date
    SELECT
        fl.player_id
    FROM FirstLogin fl
    JOIN Activity a
    ON fl.player_id = a.player_id
    WHERE a.event_date = DATE_ADD(fl.first_login_date, INTERVAL 1 DAY)
)
-- Step 3: Calculate the fraction
SELECT
    ROUND(COUNT(DISTINCT ndl.player_id) * 1.0 / COUNT(DISTINCT fl.player_id), 2) AS fraction
FROM FirstLogin fl
LEFT JOIN NextDayLogins ndl
ON fl.player_id = ndl.player_id;

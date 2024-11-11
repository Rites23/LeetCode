# Write your MySQL query statement below
SELECT e.name
FROM Employee m
JOIN Employee e ON m.managerId = e.id
GROUP BY e.id, e.name
HAVING COUNT(m.id) >= 5;

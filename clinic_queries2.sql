SELECT 
    c.name, 
    cs.uid, 
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE EXTRACT(YEAR FROM cs.datetime) = 2021  -- Replace with target year
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

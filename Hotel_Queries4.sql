WITH ItemStats AS (
    SELECT 
        EXTRACT(MONTH FROM bill_date) AS month_num,
        item_id,
        SUM(item_quantity) AS total_qty,
        RANK() OVER(PARTITION BY EXTRACT(MONTH FROM bill_date) ORDER BY SUM(item_quantity) DESC) as rank_desc,
        RANK() OVER(PARTITION BY EXTRACT(MONTH FROM bill_date) ORDER BY SUM(item_quantity) ASC) as rank_asc
    FROM booking_commercials
    WHERE EXTRACT(YEAR FROM bill_date) = 2021
    GROUP BY month_num, item_id
)
SELECT 
    month_num, 
    item_id, 
    total_qty,
    CASE WHEN rank_desc = 1 THEN 'Most Ordered' ELSE 'Least Ordered' END AS order_status
FROM ItemStats
WHERE rank_desc = 1 OR rank_asc = 1;

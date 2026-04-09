WITH StateProfits AS (
    SELECT 
        cl.state, 
        cl.clinic_name,
        (SUM(COALESCE(cs.amount, 0)) - SUM(COALESCE(ex.amount, 0))) AS profit,
        DENSE_RANK() OVER(PARTITION BY cl.state ORDER BY (SUM(COALESCE(cs.amount, 0)) - SUM(COALESCE(ex.amount, 0))) ASC) as rnk
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid = cs.cid 
        AND EXTRACT(MONTH FROM cs.datetime) = 9
    LEFT JOIN expenses ex ON cl.cid = ex.cid 
        AND EXTRACT(MONTH FROM ex.datetime) = 9
    GROUP BY cl.state, cl.clinic_name
)
SELECT state, clinic_name, profit
FROM StateProfits
WHERE rnk = 2;

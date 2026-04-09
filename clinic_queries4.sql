WITH ClinicProfits AS (
    SELECT 
        cl.city, 
        cl.clinic_name,
        (SUM(COALESCE(cs.amount, 0)) - SUM(COALESCE(ex.amount, 0))) AS profit,
        RANK() OVER(PARTITION BY cl.city ORDER BY (SUM(COALESCE(cs.amount, 0)) - SUM(COALESCE(ex.amount, 0))) DESC) as rnk
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid = cs.cid 
        AND EXTRACT(MONTH FROM cs.datetime) = 9 -- Example: September
    LEFT JOIN expenses ex ON cl.cid = ex.cid 
        AND EXTRACT(MONTH FROM ex.datetime) = 9
    GROUP BY cl.city, cl.clinic_name
)
SELECT city, clinic_name, profit
FROM ClinicProfits
WHERE rnk = 1;

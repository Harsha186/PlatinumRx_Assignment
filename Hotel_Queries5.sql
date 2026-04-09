WITH MonthlyBills AS (
    SELECT EXTRACT(MONTH FROM bc.bill_date) as month, bc.bill_id,
           SUM(bc.item_quantity * i.item_rate) as bill_value,
           DENSE_RANK() OVER(PARTITION BY EXTRACT(MONTH FROM bc.bill_date) ORDER BY SUM(bc.item_quantity * i.item_rate) DESC) as rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE EXTRACT(YEAR FROM bc.bill_date) = 2021
    GROUP BY month, bc.bill_id
)
SELECT * FROM MonthlyBills WHERE rnk = 2;

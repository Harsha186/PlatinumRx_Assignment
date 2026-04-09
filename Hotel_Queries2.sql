SELECT bc.booking_id, SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date BETWEEN '2021-11-01' AND '2021-11-30'
GROUP BY bc.booking_id;

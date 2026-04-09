SELECT sales_channel, SUM(amount) as total_revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021 -- Change year as needed
GROUP BY sales_channel;

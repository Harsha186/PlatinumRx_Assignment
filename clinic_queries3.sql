SELECT m.month, 
       rev.total_rev - COALESCE(exp.total_exp, 0) as profit,
       CASE WHEN (rev.total_rev - COALESCE(exp.total_exp, 0)) > 0 THEN 'Profitable' ELSE 'Not-Profitable' END as status
FROM (SELECT DISTINCT EXTRACT(MONTH FROM datetime) as month FROM clinic_sales) m
LEFT JOIN (SELECT EXTRACT(MONTH FROM datetime) as month, SUM(amount) as total_rev FROM clinic_sales GROUP BY 1) rev ON m.month = rev.month
LEFT JOIN (SELECT EXTRACT(MONTH FROM datetime) as month, SUM(amount) as total_exp FROM expenses GROUP BY 1) exp ON m.month = exp.month;

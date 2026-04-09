SELECT user_id, room_no
FROM (
    SELECT user_id, room_no, 
           ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY booking_date DESC) as rnk
    FROM bookings
) as latest
WHERE rnk = 1;

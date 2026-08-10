-- ============================================================
-- Hotel Reservation Analysis — Core Queries
-- Each query below reproduces one insight that originally lived
-- as an Excel PivotTable/formula, rewritten and verified in SQL.
-- ============================================================

-- 1. Most / least popular room types (by number of reservations)
-- Expected: Double 12936, Single 10764, Queen 8872, Suite 6623, King 6565, Executive Suite 4240
SELECT room_type,
       COUNT(*) AS reservation_count
FROM bookings
GROUP BY room_type
ORDER BY reservation_count DESC;


-- 2. Most effective booking channel (completed reservations only)
-- Expected: Phone App 13848, Travel Agent 10488, Website 10379, Call Center 6920, Walk-in 3400
SELECT booking_channel,
       COUNT(*) AS completed_reservations
FROM bookings
WHERE reservation_status = 'Completed'
GROUP BY booking_channel
ORDER BY completed_reservations DESC;


-- 3. Property performance — total revenue proxy (sum of avg_room_rate) and volume
-- Expected sum: The Sankey 5,064,604.53 | The Marimekko 1,505,363.53 | The Chord 787,389.15
-- Expected count: The Sankey 27400 | The Marimekko 13666 | The Chord 8934
SELECT property,
       COUNT(*)                          AS total_reservations,
       ROUND(SUM(avg_room_rate), 2)      AS total_room_rate_sum,
       ROUND(AVG(avg_room_rate), 2)      AS avg_room_rate
FROM bookings
GROUP BY property
ORDER BY total_room_rate_sum DESC;


-- 4. Reservation status breakdown
-- Expected: Completed 45035, No-Show 3550, Extended 953, Reduced 462
SELECT reservation_status,
       COUNT(*) AS reservation_count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM bookings), 2) AS pct_of_total
FROM bookings
GROUP BY reservation_status
ORDER BY reservation_count DESC;


-- 5. Advanced booking effectiveness — completion rate for booked-ahead vs. not
-- Expected: Advanced (Yes) completion rate ~90.19%, Not-advanced (No) completion rate ~89.45%
SELECT advanced_booking,
       COUNT(*) AS total_bookings,
       SUM(CASE WHEN reservation_status = 'Completed' THEN 1 ELSE 0 END) AS completed_bookings,
       ROUND(100.0 * SUM(CASE WHEN reservation_status = 'Completed' THEN 1 ELSE 0 END)
             / COUNT(*), 2) AS completion_rate_pct
FROM bookings
GROUP BY advanced_booking;


-- 6. Average room rate — headline stats
-- Expected: avg 147.15, max 288.55, min 71.10
SELECT ROUND(AVG(avg_room_rate), 2) AS avg_rate,
       MAX(avg_room_rate)          AS max_rate,
       MIN(avg_room_rate)          AS min_rate
FROM bookings;


-- 7. Weekday vs. weekend average room rate
-- Expected: Weekday 142.03, Weekend 159.81
SELECT rate_type,
       ROUND(AVG(avg_room_rate), 2) AS avg_rate
FROM bookings
GROUP BY rate_type
ORDER BY avg_rate DESC;


-- 8. Stay duration vs. special requests — do longer stays request more?
SELECT special_requests_flag,
       ROUND(AVG(stay_duration), 2) AS avg_stay_nights,
       COUNT(*) AS reservation_count
FROM bookings
GROUP BY special_requests_flag;


-- 9. Occupancy profile — average party size (adults + children) by room type
SELECT room_type,
       ROUND(AVG(adults), 2)             AS avg_adults,
       ROUND(AVG(children), 2)           AS avg_children,
       ROUND(AVG(adults + children), 2)  AS avg_party_size
FROM bookings
GROUP BY room_type
ORDER BY avg_party_size DESC;


-- 10. Monthly booking trend (based on check-in date)
SELECT strftime('%Y-%m', check_in_date) AS booking_month,
       COUNT(*) AS reservations
FROM bookings
GROUP BY booking_month
ORDER BY booking_month;

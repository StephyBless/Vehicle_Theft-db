-- =====================================================
-- STOLEN VEHICLES - ADVANCED SQL ANALYSIS SCRIPT
-- =====================================================


-- =====================================================
-- 1. BASIC DATA VIEW
-- =====================================================

SELECT * FROM stolen_vehicles;


-- =====================================================
-- 2. CASE OVERVIEW
-- =====================================================

SELECT COUNT(*) AS total_cases
FROM stolen_vehicles;

SELECT status, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY status
ORDER BY total DESC;


-- =====================================================
-- 3. VEHICLE DETAILS ANALYSIS
-- =====================================================

SELECT vehicle_make, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY vehicle_make
ORDER BY total DESC;

SELECT vehicle_model, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY vehicle_model
ORDER BY total DESC;

SELECT vehicle_color, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY vehicle_color
ORDER BY total DESC;


-- =====================================================
-- 4. TIME-BASED ANALYSIS
-- =====================================================

SELECT YEAR(theft_date) AS year, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY year
ORDER BY year DESC;

SELECT MONTH(theft_date) AS month, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY month
ORDER BY total DESC;

SELECT DATE(report_timestamp) AS report_date, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY report_date
ORDER BY report_date DESC;


-- =====================================================
-- 5. LOCATION ANALYSIS
-- =====================================================

SELECT theft_location, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY theft_location
ORDER BY total DESC;

SELECT police_station, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY police_station
ORDER BY total DESC;


-- =====================================================
-- 6. STATUS AND CASE TRACKING
-- =====================================================

SELECT *
FROM stolen_vehicles
WHERE status = 'Open';

SELECT *
FROM stolen_vehicles
WHERE status = 'Recovered';

SELECT *
FROM stolen_vehicles
ORDER BY last_updated DESC
LIMIT 5;


-- =====================================================
-- 7. VEHICLE SEARCH AND TRACKING
-- =====================================================

SELECT *
FROM stolen_vehicles
WHERE vehicle_number = 'TN01AB1234';

SELECT vehicle_number, COUNT(*) AS cases
FROM stolen_vehicles
GROUP BY vehicle_number
HAVING COUNT(*) > 1;


-- =====================================================
-- 8. ADVANCED ANALYSIS
-- =====================================================

SELECT *
FROM stolen_vehicles
WHERE theft_date > (
    SELECT AVG(theft_date)
    FROM stolen_vehicles
);

SELECT theft_location, COUNT(*) AS total
FROM stolen_vehicles
GROUP BY theft_location
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM stolen_vehicles
        GROUP BY theft_location
    ) AS temp
);


-- =====================================================
-- 9. RECENT ACTIVITY
-- =====================================================

SELECT *
FROM stolen_vehicles
WHERE report_timestamp >= NOW() - INTERVAL 7 DAY;

SELECT *
FROM stolen_vehicles
WHERE last_updated >= NOW() - INTERVAL 1 DAY;


-- =====================================================
-- 10. DATA QUALITY CHECKS
-- =====================================================

SELECT *
FROM stolen_vehicles
WHERE vehicle_number IS NULL OR vehicle_number = '';

SELECT *
FROM stolen_vehicles
WHERE owner_contact IS NULL OR owner_contact = '';

SELECT *
FROM stolen_vehicles
WHERE theft_date IS NULL;


-- =====================================================
-- END OF FILE
-- =====================================================
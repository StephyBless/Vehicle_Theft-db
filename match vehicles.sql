-- =====================================================
-- MATCH ALERTS - ADVANCED SQL ANALYSIS SCRIPT
-- =====================================================


-- =====================================================
-- 1. BASIC DATA VIEW
-- =====================================================

SELECT * FROM match_alerts;


-- =====================================================
-- 2. ALERT OVERVIEW
-- =====================================================

SELECT COUNT(*) AS total_alerts
FROM match_alerts;

SELECT severity_level, COUNT(*) AS total
FROM match_alerts
GROUP BY severity_level
ORDER BY total DESC;


-- =====================================================
-- 3. ALERT STATUS ANALYSIS
-- =====================================================

SELECT alert_status, COUNT(*) AS total
FROM match_alerts
GROUP BY alert_status
ORDER BY total DESC;

SELECT *
FROM match_alerts
WHERE alert_status = 'Pending';


-- =====================================================
-- 4. STOLEN VEHICLE MATCH ANALYSIS
-- =====================================================

SELECT *
FROM match_alerts
WHERE stolen_vehicle_id IS NOT NULL;

SELECT AVG(match_percentage) AS avg_match
FROM match_alerts;

SELECT *
FROM match_alerts
WHERE match_percentage > 80;


-- =====================================================
-- 5. HIGH PRIORITY ALERTS
-- =====================================================

SELECT *
FROM match_alerts
WHERE severity_level = 'High';

SELECT *
FROM match_alerts
ORDER BY match_percentage DESC
LIMIT 5;


-- =====================================================
-- 6. TIME-BASED ANALYSIS
-- =====================================================

SELECT DATE(alert_timestamp) AS date, COUNT(*) AS total
FROM match_alerts
GROUP BY date
ORDER BY date DESC;

SELECT HOUR(alert_timestamp) AS hour, COUNT(*) AS total
FROM match_alerts
GROUP BY hour
ORDER BY total DESC
LIMIT 1;


-- =====================================================
-- 7. VEHICLE MATCH TRACKING
-- =====================================================

SELECT detected_number, COUNT(*) AS detections
FROM match_alerts
GROUP BY detected_number
ORDER BY detections DESC;

SELECT stolen_number, COUNT(*) AS matches
FROM match_alerts
GROUP BY stolen_number
ORDER BY matches DESC;


-- =====================================================
-- 8. ACTION ANALYSIS
-- =====================================================

SELECT action_taken, COUNT(*) AS total
FROM match_alerts
GROUP BY action_taken;

SELECT *
FROM match_alerts
WHERE action_taken IS NULL OR action_taken = '';


-- =====================================================
-- 9. ADVANCED FILTERING
-- =====================================================

SELECT *
FROM match_alerts
WHERE match_percentage > (
    SELECT AVG(match_percentage)
    FROM match_alerts
);

SELECT severity_level, COUNT(*) AS total
FROM match_alerts
GROUP BY severity_level
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM match_alerts
        GROUP BY severity_level
    ) AS temp
);


-- =====================================================
-- 10. REAL-TIME ALERT MONITORING
-- =====================================================

SELECT *
FROM match_alerts
WHERE alert_timestamp >= NOW() - INTERVAL 10 MINUTE;

SELECT severity_level, COUNT(*) AS total
FROM match_alerts
WHERE alert_timestamp >= NOW() - INTERVAL 1 HOUR
GROUP BY severity_level
ORDER BY total DESC;


-- =====================================================
-- 11. DATA QUALITY CHECKS
-- =====================================================

SELECT *
FROM match_alerts
WHERE detected_number IS NULL OR detected_number = '';

SELECT *
FROM match_alerts
WHERE match_percentage < 0 OR match_percentage > 100;


-- =====================================================
-- END OF FILE
-- =====================================================
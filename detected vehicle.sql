
-- =====================================================
-- 1. BASIC DATA VIEW
-- =====================================================

SELECT * FROM detected_vehicles;

-- =====================================================
-- 2. STOLEN VEHICLE ANALYSIS
-- =====================================================

SELECT * 
FROM detected_vehicles
WHERE matched_stolen_id IS NOT NULL;

SELECT match_severity, COUNT(*) AS total
FROM detected_vehicles
WHERE matched_stolen_id IS NOT NULL
GROUP BY match_severity
ORDER BY total DESC;

SELECT *
FROM detected_vehicles
WHERE matched_stolen_id IS NOT NULL
ORDER BY detection_timestamp DESC
LIMIT 1;


-- =====================================================
-- 3. VEHICLE TRACKING
-- =====================================================

SELECT vehicle_number, detection_location, detection_timestamp
FROM detected_vehicles
WHERE vehicle_number = 'TN01AB1234'
ORDER BY detection_timestamp;

SELECT vehicle_number, detection_location, MAX(detection_timestamp) AS last_seen
FROM detected_vehicles
GROUP BY vehicle_number;


-- =====================================================
-- 4. TRAFFIC ANALYSIS
-- =====================================================

SELECT HOUR(detection_timestamp) AS hour, COUNT(*) AS total
FROM detected_vehicles
GROUP BY hour
ORDER BY total DESC
LIMIT 1;

SELECT detection_location, COUNT(*) AS total
FROM detected_vehicles
GROUP BY detection_location
ORDER BY total DESC;


-- =====================================================
-- 5. AI MODEL PERFORMANCE ANALYSIS
-- =====================================================

SELECT AVG(confidence_score) AS avg_confidence
FROM detected_vehicles;

SELECT *
FROM detected_vehicles
WHERE confidence_score < 0.5;

SELECT cam_id, AVG(confidence_score) AS avg_conf
FROM detected_vehicles
GROUP BY cam_id
ORDER BY avg_conf DESC
LIMIT 1;


-- =====================================================
-- 6. SUSPICIOUS ACTIVITY DETECTION
-- =====================================================

SELECT vehicle_number, COUNT(*) AS detections
FROM detected_vehicles
WHERE detection_timestamp >= NOW() - INTERVAL 10 MINUTE
GROUP BY vehicle_number
HAVING COUNT(*) > 3;


-- =====================================================
-- 7. ADVANCED SUBQUERIES
-- =====================================================

SELECT *
FROM detected_vehicles
WHERE confidence_score > (
    SELECT AVG(confidence_score)
    FROM detected_vehicles
);

SELECT detection_location, COUNT(*) AS total
FROM detected_vehicles
GROUP BY detection_location
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM detected_vehicles
        GROUP BY detection_location
    ) AS temp
);


-- =====================================================
-- 8. REAL-TIME MONITORING
-- =====================================================

SELECT *
FROM detected_vehicles
WHERE detection_timestamp >= NOW() - INTERVAL 5 MINUTE;

SELECT cam_id, COUNT(*) AS activity
FROM detected_vehicles
WHERE detection_timestamp >= NOW() - INTERVAL 1 HOUR
GROUP BY cam_id
ORDER BY activity DESC;


-- =====================================================
-- 9. DATA QUALITY CHECKS
-- =====================================================

SELECT *
FROM detected_vehicles
WHERE vehicle_number IS NULL OR vehicle_number = '';

SELECT *
FROM detected_vehicles
WHERE confidence_score < 0 OR confidence_score > 1;

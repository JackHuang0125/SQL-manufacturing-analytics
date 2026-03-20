SELECT
    defect_type,
    SUM(defect_count) AS total_defects
FROM defects
GROUP BY defect_type
ORDER BY total_defects DESC;

SELECT
    l.shift,
    AVG(me.yield_rate) AS avg_yield
FROM lots l
JOIN measurements me
    ON l.lot_id = me.lot_id
GROUP BY l.shift;
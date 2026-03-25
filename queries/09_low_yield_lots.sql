WITH lot_summary AS (
    SELECT
        l.lot_no,
        m.machine_name,
        l.shift,
        ROUND(AVG(me.yield_rate), 2) AS avg_yield,
        COALESCE(SUM(d.defect_count), 0) AS total_defects
    FROM lots l
    JOIN machines m ON l.machine_id = m.machine_id
    JOIN measurements me ON l.lot_id = me.lot_id
    LEFT JOIN defects d ON l.lot_id = d.lot_id
    GROUP BY l.lot_no, m.machine_name, l.shift
)
SELECT *
FROM lot_summary
WHERE avg_yield < 93
ORDER BY avg_yield ASC, total_defects DESC;


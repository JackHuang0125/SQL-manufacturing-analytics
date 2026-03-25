EXPLAIN
SELECT
    m.machine_name,
    ROUND(AVG(me.yield_rate), 2) AS avg_yield
FROM machines m
JOIN lots l ON m.machine_id = l.machine_id
JOIN measurements me ON l.lot_id = me.lot_id
GROUP BY m.machine_name;
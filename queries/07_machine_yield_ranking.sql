SELECT
    m.machine_name,
    ROUND(AVG(me.yield_rate), 2) AS avg_yield,
    RANK() OVER (ORDER BY AVG(me.yield_rate) DESC) AS yield_rank
FROM machines m
JOIN lots l ON m.machine_id = l.machine_id
JOIN measurements me ON l.lot_id = me.lot_id
GROUP BY m.machine_name
ORDER BY avg_yield DESC;

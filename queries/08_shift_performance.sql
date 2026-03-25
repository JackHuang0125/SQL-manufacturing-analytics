SELECT
    l.shift,
    ROUND(AVG(me.yield_rate), 2) AS avg_yield,
    ROUND(STDDEV(me.yield_rate), 2) AS yield_std
FROM lots l
JOIN measurements me ON l.lot_id = me.lot_id
GROUP BY l.shift;
SELECT
    l.lot_no,
    m.machine_name,
    me.yield_rate,
    RANK() OVER (ORDER BY me.yield_rate DESC) AS yield_rank
FROM lots l
JOIN machines m
    ON l.machine_id = m.machine_id
JOIN measurements me
    ON l.lot_id = me.lot_id;

SELECT
    l.lot_no,
    me.measure_time,
    me.yield_rate,
    AVG(me.yield_rate) OVER (
        ORDER BY me.measure_time
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_yield
FROM lots l
JOIN measurements me
    ON l.lot_id = me.lot_id;
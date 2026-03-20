WITH lot_yield AS (
    SELECT
        l.lot_no,
        m.machine_name,
        me.yield_rate
    FROM lots l
    JOIN machines m
        ON l.machine_id = m.machine_id
    JOIN measurements me
        ON l.lot_id = me.lot_id
)
SELECT *
FROM lot_yield
WHERE yield_rate < 95;
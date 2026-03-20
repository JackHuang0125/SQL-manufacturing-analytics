SELECT
    l.lot_no,
    l.product_type,
    m.machine_name,
    m.process_stage,
    me.yield_rate
FROM lots l
JOIN machines m
    ON l.machine_id = m.machine_id
JOIN measurements me
    ON l.lot_id = me.lot_id;

SELECT
    l.lot_no,
    d.defect_type,
    d.defect_count
FROM lots l
LEFT JOIN defects d
    ON l.lot_id = d.lot_id;
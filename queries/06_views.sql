CREATE OR REPLACE VIEW vw_lot_quality_summary AS
SELECT
    l.lot_no,
    l.product_type,
    l.shift,
    m.machine_name,
    m.process_stage,
    me.temperature,
    me.pressure,
    me.thickness,
    me.yield_rate,
    COALESCE(SUM(d.defect_count), 0) AS total_defects
FROM lots l
JOIN machines m
    ON l.machine_id = m.machine_id
JOIN measurements me
    ON l.lot_id = me.lot_id
LEFT JOIN defects d
    ON l.lot_id = d.lot_id
GROUP BY
    l.lot_no, l.product_type, l.shift,
    m.machine_name, m.process_stage,
    me.temperature, me.pressure, me.thickness, me.yield_rate;

SELECT *
FROM vw_lot_quality_summary;
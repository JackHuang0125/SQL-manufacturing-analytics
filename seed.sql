TRUNCATE TABLE measurements, defects, lots, machines RESTART IDENTITY CASCADE;

INSERT INTO machines (machine_name, process_stage, line_name) VALUES
('ETCH_01', 'Etch', 'LINE_A'),
('ETCH_02', 'Etch', 'LINE_A'),
('CVD_01', 'Deposition', 'LINE_B'),
('PHOTO_01', 'Lithography', 'LINE_C'),
('CMP_01', 'CMP', 'LINE_B'),
('IMPLANT_01', 'Ion Implantation', 'LINE_D');

INSERT INTO lots (lot_no, product_type, start_date, shift, machine_id)
SELECT
    'LOT' || LPAD(gs::text, 3, '0'),
    CASE
        WHEN gs%2=0 THEN 'Logic'
        ELSE 'Memory'
    END,
    DATE '2026-03-01'+((gs-1)/10),
    CASE
        WHEN gs%3=0 THEN 'Night'
        ELSE 'Day'
    END,
    ((gs-1)%6)+1
FROM generate_series(1, 100) AS gs;

INSERT INTO measurements (lot_id, measure_time, temperature, pressure, thickness, yield_rate)
SELECT
    l.lot_id,
    l.start_date + TIME '08:00' + ((g-1)*INTERVAL '2 hour'),
    ROUND((180+(random()*12))::numeric, 2),
    ROUND((1.00+(random()*0.5))::numeric, 2),
    ROUND((95+(random()*8))::numeric, 2),
    ROUND((
        CASE
            WHEN l.machine_id IN (2, 4) AND random()<0.25 THEN 88+random()*5
            ELSE 94+random()*5
        END
    )::numeric, 2)
FROM lots l
CROSS JOIN generate_series(1, 4) AS g;

INSERT INTO defects (lot_id, defect_type, defect_count, inspection_date)
SELECT
    l.lot_id,
    CASE
        WHEN l.machine_id=2 THEN 'Scratch'
        WHEN l.machine_id=4 THEN 'Overlay'
        ELSE 'Particle'
    END,
    CASE
        WHEN l.machine_id IN (2, 4) THEN (10+floor(random()*20))::int
        ELSE (1+floor(random()*10))::int
    END,
    l.start_date
FROM lots l
WHERE random()<0.8;

ANALYZE;

INSERT INTO machines (machine_name, process_stage, line_name) VALUES
('ETCH_01', 'Etch', 'LINE_A'),
('ETCH_02', 'Etch', 'LINE_A'),
('CVD_01', 'Deposition', 'LINE_B'),
('PHOTO_01', 'Lithography', 'LINE_C');

INSERT INTO lots (lot_no, product_type, start_date, shift, machine_id) VALUES
('LOT001', 'Logic', '2026-03-01', 'Day', 1),
('LOT002', 'Logic', '2026-03-01', 'Night', 1),
('LOT003', 'Memory', '2026-03-02', 'Day', 2),
('LOT004', 'Logic', '2026-03-02', 'Night', 3),
('LOT005', 'Memory', '2026-03-03', 'Day', 4),
('LOT006', 'Logic', '2026-03-03', 'Night', 2);

INSERT INTO measurements (lot_id, measure_time, temperature, pressure, thickness, yield_rate) VALUES
(1, '2026-03-01 08:30:00', 182.5, 1.20, 98.4, 96.2),
(2, '2026-03-01 20:30:00', 185.1, 1.35, 97.2, 93.8),
(3, '2026-03-02 09:10:00', 180.3, 1.10, 99.1, 97.5),
(4, '2026-03-02 21:00:00', 188.9, 1.42, 96.5, 91.4),
(5, '2026-03-03 10:20:00', 176.8, 1.05, 100.2, 98.1),
(6, '2026-03-03 22:10:00', 187.2, 1.38, 96.9, 92.6);

INSERT INTO defects (lot_id, defect_type, defect_count, inspection_date) VALUES
(1, 'Particle', 12, '2026-03-01'),
(2, 'Scratch', 21, '2026-03-01'),
(3, 'Particle', 8,  '2026-03-02'),
(4, 'Overlay', 26, '2026-03-02'),
(5, 'Particle', 5,  '2026-03-03'),
(6, 'Scratch', 19, '2026-03-03');
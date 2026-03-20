DROP TABLE IF EXISTS defects;
DROP TABLE IF EXISTS measurements;
DROP TABLE IF EXISTS lots;
DROP TABLE IF EXISTS machines;

CREATE TABLE machines (
    machine_id SERIAL PRIMARY KEY,
    machine_name VARCHAR(50) NOT NULL,
    process_stage VARCHAR(50) NOT NULL,
    line_name VARCHAR(20) NOT NULL
);

CREATE TABLE lots (
    lot_id SERIAL PRIMARY KEY,
    lot_no VARCHAR(30) NOT NULL UNIQUE,
    product_type VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    shift VARCHAR(10) NOT NULL,
    machine_id INT NOT NULL REFERENCES machines(machine_id)
);

CREATE TABLE measurements (
    measurement_id SERIAL PRIMARY KEY,
    lot_id INT NOT NULL REFERENCES lots(lot_id),
    measure_time TIMESTAMP NOT NULL,
    temperature NUMERIC(6,2),
    pressure NUMERIC(6,2),
    thickness NUMERIC(6,2),
    yield_rate NUMERIC(5,2)
);

CREATE TABLE defects (
    defect_id SERIAL PRIMARY KEY,
    lot_id INT NOT NULL REFERENCES lots(lot_id),
    defect_type VARCHAR(50) NOT NULL,
    defect_count INT NOT NULL,
    inspection_date DATE NOT NULL
);
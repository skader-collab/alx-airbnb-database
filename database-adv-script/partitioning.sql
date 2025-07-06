-- Partitioning the Booking (reservations) table by start_date (PostgreSQL example)
-- Step 1: Create a new partitioned table
CREATE TABLE reservations_partitioned (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    room_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP,
    -- add other columns as needed
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT fk_room FOREIGN KEY(room_id) REFERENCES rooms(id)
) PARTITION BY RANGE (start_date);

CREATE TABLE reservations_partitioned_2023 PARTITION OF reservations_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE reservations_partitioned_2024 PARTITION OF reservations_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE reservations_partitioned_2025 PARTITION OF reservations_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE reservations_partitioned_max PARTITION OF reservations_partitioned
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- Step 3: (Optional) Insert data from the original table
-- INSERT INTO reservations_partitioned SELECT * FROM reservations;

-- Step 4: Example query to test performance
EXPLAIN ANALYZE
SELECT * FROM reservations_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Step 5: Compare with non-partitioned table
EXPLAIN ANALYZE SELECT * FROM reservations WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

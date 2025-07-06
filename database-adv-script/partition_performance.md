# Partitioning Performance Report

## Objective
Optimize query performance on the large `reservations` (Booking) table by implementing table partitioning based on the `start_date` column.

## Steps Taken
1. Created a partitioned version of the `reservations` table using PostgreSQL's RANGE partitioning on `start_date`.
2. Created yearly partitions for 2023, 2024, and 2025.
3. Tested query performance for fetching bookings within a date range using `EXPLAIN ANALYZE`.
4. Compared performance with the original (non-partitioned) table.

## Observations
- **Partitioned Table:**
  - The query planner only scans the relevant partition(s) for the specified date range, reducing I/O and improving performance.
  - `EXPLAIN ANALYZE` shows fewer rows scanned and lower execution time for date range queries.
- **Non-Partitioned Table:**
  - The query scans the entire table, resulting in higher I/O and slower performance, especially as the table grows.

## Example Results
- **Partitioned Table:**
  - `EXPLAIN ANALYZE SELECT * FROM reservations_partitioned WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';`
  - Execution time: *Significantly lower* (scans only 2024 partition)
- **Non-Partitioned Table:**
  - `EXPLAIN ANALYZE SELECT * FROM reservations WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';`
  - Execution time: *Higher* (scans all rows)

## Conclusion
Partitioning the `reservations` table by `start_date` greatly improves query performance for date-based queries by limiting scans to relevant partitions. This approach is highly recommended for large, time-series-like tables.

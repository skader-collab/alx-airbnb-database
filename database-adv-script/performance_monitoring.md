# Database Performance Monitoring and Refinement

This document outlines a continuous process for monitoring and refining the performance of your PostgreSQL database, using real query analysis and schema adjustments as examples from this project.

---

## 1. Monitor Query Performance

Use `EXPLAIN ANALYZE` to inspect how queries are executed and to identify bottlenecks.

**Example:**
```sql
EXPLAIN ANALYZE
SELECT * FROM reservations_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
```

**What to look for:**
- Sequential scans (Seq Scan) on large tables (can be slow)
- Index scans (Index Scan) or partition pruning (good for performance)
- High cost or long execution time

---

## 2. Identify Bottlenecks

If you see `Seq Scan` on large partitions or slow performance, it may indicate missing indexes or suboptimal partitioning. Use `EXPLAIN ANALYZE` on your most frequent queries to spot these issues.

**Example:**
```sql
EXPLAIN ANALYZE
SELECT r.id AS reservation_id, r.start_date, r.end_date,
       u.name AS user_name, rm.title AS room_title, p.amount
FROM reservations r
JOIN users u ON r.user_id = u.id
JOIN rooms rm ON r.room_id = rm.id
LEFT JOIN payments p ON r.id = p.reservation_id
WHERE r.start_date >= '2024-01-01' AND p.status = 'completed';
```

---

## 3. Implement Schema Adjustments

### a. Add Indexes

If queries often filter or join by `user_id`, `room_id`, or `reservation_id`, add indexes to speed up lookups:

```sql
CREATE INDEX IF NOT EXISTS idx_reservations_user_id ON reservations(user_id);
CREATE INDEX IF NOT EXISTS idx_reservations_room_id ON reservations(room_id);
CREATE INDEX IF NOT EXISTS idx_payments_reservation_id ON payments(reservation_id);
```

For partitioned tables, add indexes to each partition as needed.

### b. Adjust Partitioning

If most queries target recent data, consider creating partitions for each year or quarter. Example from `partitioning.sql`:

```sql
CREATE TABLE reservations_partitioned_2024 PARTITION OF reservations_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
```

---

## 4. Report and Compare Improvements

After making changes, rerun `EXPLAIN ANALYZE` to compare execution plans and timings before and after. Look for:
- Use of Index Scan instead of Seq Scan
- Lower execution time
- Partition pruning

**Example:**
```sql
EXPLAIN ANALYZE
SELECT r.id AS reservation_id, r.start_date, r.end_date,
       u.name AS user_name, rm.title AS room_title, p.amount
FROM reservations r
JOIN users u ON r.user_id = u.id
JOIN rooms rm ON r.room_id = rm.id
LEFT JOIN payments p ON r.id = p.reservation_id
WHERE r.start_date >= '2024-01-01' AND p.status = 'completed';
```

---

## 5. Continuous Monitoring

- Regularly analyze your most frequent queries with `EXPLAIN ANALYZE`.
- Use PostgreSQL’s `pg_stat_statements` extension for ongoing query monitoring.
- Adjust indexes and partitions as query patterns change.

---

## Summary Table

| Step                | Action/Command Example                                                                 |
|---------------------|--------------------------------------------------------------------------------------|
| Monitor             | `EXPLAIN ANALYZE SELECT ...`                                                          |
| Identify Bottleneck | Look for `Seq Scan`, high cost, slow queries                                         |
| Add Index           | `CREATE INDEX ...`                                                                    |
| Adjust Partition    | `CREATE TABLE ... PARTITION OF ... FOR VALUES ...`                                    |
| Compare             | Rerun `EXPLAIN ANALYZE` and compare execution plans                                   |
| Continuous Monitor  | Use `pg_stat_statements`, regular review                                             |

---

**Keep this process iterative: monitor, adjust, and re-measure to ensure optimal performance as your data and query patterns evolve.**

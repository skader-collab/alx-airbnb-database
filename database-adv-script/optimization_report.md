# Optimization Report: Bookings Query Performance

## Initial Query
The initial query retrieves all bookings with user, property, and payment details:

```sql
SELECT r.id AS reservation_id, r.start_date, r.end_date, r.created_at AS reservation_created_at,
       u.id AS user_id, u.name AS user_name, u.email AS user_email,
       rm.id AS room_id, rm.title AS room_title, rm.host_id, rm.created_at AS room_created_at,
       p.id AS payment_id, p.amount, p.status, p.created_at AS payment_created_at
FROM reservations r
JOIN users u ON r.user_id = u.id
JOIN rooms rm ON r.room_id = rm.id
LEFT JOIN payments p ON r.id = p.reservation_id;
```

## Performance Analysis
- Used `EXPLAIN` to analyze the query plan.
- Potential inefficiencies:
  - Full table scans if indexes are missing on join columns (`reservations.user_id`, `reservations.room_id`, `payments.reservation_id`).
  - Unnecessary columns or joins if not all details are needed.

## Refactored Query
- Ensure indexes exist on join columns for faster lookups.
- Only select necessary columns.
- Use `INNER JOIN` for payments if every reservation has a payment, otherwise keep `LEFT JOIN`.

```sql
-- Ensure indexes exist (if not already created):
CREATE INDEX IF NOT EXISTS idx_reservations_user_id ON reservations(user_id);
CREATE INDEX IF NOT EXISTS idx_reservations_room_id ON reservations(room_id);
CREATE INDEX IF NOT EXISTS idx_payments_reservation_id ON payments(reservation_id);

-- Refactored query
SELECT r.id AS reservation_id, r.start_date, r.end_date,
       u.name AS user_name, rm.title AS room_title, p.amount
FROM reservations r
JOIN users u ON r.user_id = u.id
JOIN rooms rm ON r.room_id = rm.id
LEFT JOIN payments p ON r.id = p.reservation_id;
```

## Summary
- Indexes on join columns significantly reduce execution time.
- Selecting only required columns further improves performance.
- Use `EXPLAIN` to verify improved query plan.

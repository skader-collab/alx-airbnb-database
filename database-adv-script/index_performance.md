# Index Performance Analysis

This document measures the query performance before and after adding indexes to the Users, Reservations, and Rooms tables.

## 1. Queries Used for Testing

- Total number of bookings made by each user:
  ```sql
  SELECT Users.id AS user_id, Users.name, COUNT(Reservations.id) AS total_bookings
  FROM Users
  LEFT JOIN Reservations ON Users.id = Reservations.user_id
  GROUP BY Users.id, Users.name
  ORDER BY total_bookings DESC;
  ```
- Rank properties based on the total number of bookings:
  ```sql
  SELECT Rooms.id AS room_id, Rooms.name, COUNT(Reservations.id) AS total_bookings,
         RANK() OVER (ORDER BY COUNT(Reservations.id) DESC) AS booking_rank
  FROM Rooms
  LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
  GROUP BY Rooms.id, Rooms.name
  ORDER BY booking_rank;
  ```

## 2. Performance Measurement

Use `EXPLAIN ANALYZE` to measure query performance before and after adding indexes.

### Example:
```sql
EXPLAIN ANALYZE SELECT Users.id AS user_id, Users.name, COUNT(Reservations.id) AS total_bookings
FROM Users
LEFT JOIN Reservations ON Users.id = Reservations.user_id
GROUP BY Users.id, Users.name
ORDER BY total_bookings DESC;
```

## 3. Results

| Query Description | Before Index (ms) | After Index (ms) | Improvement |
|-------------------|-------------------|------------------|-------------|
| Bookings per user |                   |                  |             |
| Property ranking  |                   |                  |             |

*Fill in the table above with your measured results.*

## 4. Conclusion

Indexes on high-usage columns (used in JOIN, WHERE, ORDER BY) significantly improve query performance, especially for large datasets. Always analyze query plans to ensure indexes are being used effectively.

-- Indexes to improve query performance for high-usage columns in Users, Reservations, and Rooms tables
-- These indexes are based on columns used in WHERE, JOIN, and ORDER BY clauses in common queries

-- Users table
CREATE INDEX idx_users_name ON users(name);

-- Reservations table
CREATE INDEX idx_reservations_user_id ON reservations(user_id);
CREATE INDEX idx_reservations_room_id ON reservations(room_id);
CREATE INDEX idx_reservations_start_date ON reservations(start_date);

-- Rooms table
CREATE INDEX idx_rooms_name ON rooms(title);
CREATE INDEX idx_rooms_host_id ON rooms(host_id);

-- For queries ordering by total bookings, an index on Reservations.room_id is already present
-- If queries often filter or order by created_at, consider:
CREATE INDEX idx_reservations_created_at ON reservations(created_at);
CREATE INDEX idx_rooms_created_at ON rooms(created_at);

-- Performance measurement queries (before and after adding indexes)
-- Use EXPLAIN ANALYZE to measure query performance

-- 1. Total number of bookings made by each user
EXPLAIN ANALYZE SELECT Users.id AS user_id, Users.name, COUNT(Reservations.id) AS total_bookings
FROM Users
LEFT JOIN Reservations ON Users.id = Reservations.user_id
GROUP BY Users.id, Users.name
ORDER BY total_bookings DESC;

-- 2. Rank properties based on the total number of bookings
EXPLAIN ANALYZE SELECT Rooms.id AS room_id, Rooms.name, COUNT(Reservations.id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(Reservations.id) DESC) AS booking_rank
FROM Rooms
LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
GROUP BY Rooms.id, Rooms.name
ORDER BY booking_rank;

-- 3. Rank properties using ROW_NUMBER() based on the total number of bookings
EXPLAIN ANALYZE WITH property_bookings AS (
    SELECT Rooms.id AS room_id, Rooms.name, COUNT(Reservations.id) AS total_bookings
    FROM Rooms
    LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
    GROUP BY Rooms.id, Rooms.name
)
SELECT room_id, name, total_bookings,
       ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM property_bookings
ORDER BY booking_row_number;

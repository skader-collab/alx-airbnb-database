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

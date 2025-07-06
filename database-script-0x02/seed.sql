-- Airbnb Database Sample Data
-- Run after creating the schema from ../database-script-0x01/schema.sql

-- USERS
INSERT INTO Users (id, name, email, phone, created_at) VALUES
  (1, 'Alice Smith', 'alice@example.com', '555-1234', '2024-01-10'),
  (2, 'Bob Johnson', 'bob@example.com', '555-2345', '2024-02-15'),
  (3, 'Carol Lee', 'carol@example.com', '555-3456', '2024-03-20');

-- HOSTS
INSERT INTO Hosts (id, user_id, superhost, joined_at) VALUES
  (1, 2, TRUE, '2024-02-16'),
  (2, 3, FALSE, '2024-03-21');

-- LOCATIONS
INSERT INTO Locations (id, city, country) VALUES
  (1, 'New York', 'USA'),
  (2, 'Paris', 'France');

-- ROOMS / PROPERTIES
INSERT INTO Rooms (id, host_id, location_id, name, room_type, price_per_night, max_guests, created_at) VALUES
  (1, 1, 1, 'Cozy Manhattan Studio', 'Entire home/apt', 150, 2, '2024-02-20'),
  (2, 2, 2, 'Charming Paris Flat', 'Private room', 90, 1, '2024-03-25');

-- AMENITIES
INSERT INTO Amenities (id, name) VALUES
  (1, 'WiFi'),
  (2, 'Air Conditioning'),
  (3, 'Kitchen'),
  (4, 'Washer');

-- ROOM_AMENITIES (join table)
INSERT INTO Room_Amenities (room_id, amenity_id) VALUES
  (1, 1), (1, 2), (1, 3),
  (2, 1), (2, 4);

-- RESERVATIONS / BOOKINGS
INSERT INTO Reservations (id, user_id, room_id, check_in, check_out, guests, status, created_at) VALUES
  (1, 1, 1, '2024-04-01', '2024-04-05', 2, 'confirmed', '2024-03-01'),
  (2, 1, 2, '2024-05-10', '2024-05-12', 1, 'cancelled', '2024-04-15'),
  (3, 3, 1, '2024-06-01', '2024-06-03', 1, 'confirmed', '2024-05-10');

-- PAYMENTS
INSERT INTO Payments (id, reservation_id, amount, paid_at, payment_method, status) VALUES
  (1, 1, 600, '2024-03-02', 'credit_card', 'paid'),
  (2, 2, 180, '2024-04-16', 'paypal', 'refunded'),
  (3, 3, 300, '2024-05-11', 'credit_card', 'paid');

-- REVIEWS
INSERT INTO Reviews (id, reservation_id, rating, comment, created_at) VALUES
  (1, 1, 5, 'Great stay, very clean and central!', '2024-04-06'),
  (2, 3, 4, 'Nice place, but a bit noisy.', '2024-06-04');

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT Reservations.*, Users.name, Users.email
FROM Reservations
INNER JOIN Users ON Reservations.user_id = Users.id
ORDER BY Reservations.id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT Rooms.*, Reviews.rating, Reviews.comment, Reviews.created_at
FROM Rooms
LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
LEFT JOIN Reviews ON Reservations.id = Reviews.reservation_id
ORDER BY Rooms.id, Reviews.created_at;

-- 3. FULL OUTER JOIN (emulated with LEFT JOIN and UNION): Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT Users.*, Reservations.*
FROM Users
LEFT JOIN Reservations ON Users.id = Reservations.user_id
UNION
SELECT Users.*, Reservations.*
FROM Reservations
LEFT JOIN Users ON Reservations.user_id = Users.id
ORDER BY Users.id, Reservations.id;

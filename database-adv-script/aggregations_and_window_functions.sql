-- 1. Total number of bookings made by each user
SELECT Users.id AS user_id, Users.name, COUNT(Reservations.id) AS total_bookings
FROM Users
LEFT JOIN Reservations ON Users.id = Reservations.user_id
GROUP BY Users.id, Users.name
ORDER BY total_bookings DESC;

-- 2. Rank properties based on the total number of bookings they have received
SELECT Rooms.id AS room_id, Rooms.name, COUNT(Reservations.id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(Reservations.id) DESC) AS booking_rank
FROM Rooms
LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
GROUP BY Rooms.id, Rooms.name
ORDER BY booking_rank;

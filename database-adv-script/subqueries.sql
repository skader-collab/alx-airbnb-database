-- 1. Find all properties where the average rating is greater than 4.0 using a subquery (non-correlated)
SELECT Rooms.*
FROM Rooms
WHERE Rooms.id IN (
    SELECT Reservations.room_id
    FROM Reservations
    JOIN Reviews ON Reservations.id = Reviews.reservation_id
    GROUP BY Reservations.room_id
    HAVING AVG(Reviews.rating) > 4.0
);

-- 2. Find users who have made more than 3 bookings (correlated subquery)
SELECT Users.*
FROM Users
WHERE (
    SELECT COUNT(*)
    FROM Reservations
    WHERE Reservations.user_id = Users.id
) > 3;

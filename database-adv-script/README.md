# SQL Join Queries for Airbnb Database

This file contains advanced SQL join queries for the Airbnb database project.

## 1. INNER JOIN: Bookings and Users
Retrieves all bookings and the respective users who made those bookings.
```sql
SELECT Reservations.*, Users.name, Users.email
FROM Reservations
INNER JOIN Users ON Reservations.user_id = Users.id;
```

## 2. LEFT JOIN: Properties and Reviews
Retrieves all properties and their reviews, including properties that have no reviews.
```sql
SELECT Rooms.*, Reviews.rating, Reviews.comment, Reviews.created_at
FROM Rooms
LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
LEFT JOIN Reviews ON Reservations.id = Reviews.reservation_id;
```

## 3. FULL OUTER JOIN: Users and Bookings
Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.
```sql
SELECT Users.*, Reservations.*
FROM Users
FULL OUTER JOIN Reservations ON Users.id = Reservations.user_id;
```

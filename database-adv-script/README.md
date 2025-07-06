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

# Subqueries in SQL

This file contains examples of both correlated and non-correlated subqueries for the Airbnb database project.

## 1. Properties with Average Rating > 4.0 (Non-correlated Subquery)

Find all properties (rooms) where the average rating is greater than 4.0:

```sql
SELECT Rooms.*
FROM Rooms
WHERE Rooms.id IN (
    SELECT Reservations.room_id
    FROM Reservations
    JOIN Reviews ON Reservations.id = Reviews.reservation_id
    GROUP BY Reservations.room_id
    HAVING AVG(Reviews.rating) > 4.0
);
```

## 2. Users with More Than 3 Bookings (Correlated Subquery)

Find all users who have made more than 3 bookings:

```sql
SELECT Users.*
FROM Users
WHERE (
    SELECT COUNT(*)
    FROM Reservations
    WHERE Reservations.user_id = Users.id
) > 3;
```

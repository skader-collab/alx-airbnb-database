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

# Aggregations and Window Functions

This section contains SQL queries that demonstrate the use of aggregation and window functions for analyzing Airbnb database data.

## 4. Total number of bookings made by each user
This query uses the `COUNT` function and `GROUP BY` clause to find the total number of bookings made by each user:

```sql
SELECT Users.id AS user_id, Users.name, COUNT(Reservations.id) AS total_bookings
FROM Users
LEFT JOIN Reservations ON Users.id = Reservations.user_id
GROUP BY Users.id, Users.name
ORDER BY total_bookings DESC;
```

## 5. Rank properties based on the total number of bookings
This query uses the `RANK()` window function to rank properties based on the total number of bookings they have received:

```sql
SELECT Rooms.id AS room_id, Rooms.name, COUNT(Reservations.id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(Reservations.id) DESC) AS booking_rank
FROM Rooms
LEFT JOIN Reservations ON Rooms.id = Reservations.room_id
GROUP BY Rooms.id, Rooms.name
ORDER BY booking_rank;
```

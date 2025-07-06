# Database Normalization to 3NF

## 1. First Normal Form (1NF)
- Ensure each table has a primary key.
- All attributes contain only atomic (indivisible) values.
- No repeating groups or arrays.

**Example:**
- Split address into street, city, state, zip instead of a single address field.

## 2. Second Normal Form (2NF)
- Meet all requirements of 1NF.
- Remove partial dependencies: all non-key attributes must depend on the whole primary key (for tables with composite keys).

**Example:**
- In a reservation table with (user_id, room_id) as a composite key, ensure attributes like user_email are not stored here (should be in the user table).

## 3. Third Normal Form (3NF)
- Meet all requirements of 2NF.
- Remove transitive dependencies: non-key attributes must depend only on the primary key.

**Example:**
- If a table has columns (room_id, host_id, host_email), move host_email to the host table, not the room table.

---

## Normalization Steps Applied to Airbnb Database

1. **Users Table**
   - Each user has a unique user_id (PK).
   - All user attributes (name, email, etc.) are atomic.
   - No redundant data (e.g., no address details in reservations).

2. **Rooms Table**
   - Each room has a unique room_id (PK).
   - Host information is referenced by host_id (FK), not duplicated.

3. **Reservations Table**
   - Each reservation has a unique reservation_id (PK).
   - References user_id and room_id as FKs.
   - No user or room details stored here.

4. **Reviews Table**
   - Each review has a unique review_id (PK).
   - References user_id and room_id as FKs.
   - Only review-specific data stored.

5. **Other Entities**
   - Amenities, locations, etc., are separated into their own tables and referenced by FKs.

---

## Summary
- All tables have atomic attributes and primary keys (1NF).
- No partial dependencies in tables with composite keys (2NF).
- No transitive dependencies; all non-key attributes depend only on the primary key (3NF).
- Redundant data is eliminated by referencing related entities via foreign keys.

This ensures the database is in Third Normal Form (3NF), reducing redundancy and improving data integrity.

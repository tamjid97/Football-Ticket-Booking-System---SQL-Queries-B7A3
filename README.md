# Football Ticket Booking System - Database Design & SQL Queries

This repository contains the database design (ERD) and intermediate-to-advanced SQL queries for a simplified **Football Ticket Booking System**. Built as part of the database assignment to demonstrate proficiency in schema design, referential integrity, and complex query implementation.

---

## 🗺️ Entity Relationship Diagram (ERD)

The database schema manages relationships between administrative staff/fans, upcoming tournament matches, and individual ticket booking receipts.

*   **ERD Live Link:** [DrawSQL - Football Ticket Booking System](https://drawsql.app/teams/epick/diagrams/football-ticket-booking-system)

### Key Relationships Covered:
*   **One-to-Many (`Users` ──◄ `Bookings`):** A single football fan can buy tickets for multiple matches throughout the season.
*   **Many-to-One (`Bookings` ►── `Matches`):** A major derby match can be associated with thousands of individual booking records from different fans.
*   **One-to-One (Logical):** Each specific row in the booking table maps exactly one user to one match for a designated seat.

---

## 🛠️ Database Schema & Features

The project includes the implementation of three core tables with optimal data types, structural constraints (`PRIMARY KEY`, `FOREIGN KEY`), and data validations (`CHECK` constraints):

1.  **`Users` Table:** Tracks administrative staff and customers (`Ticket Manager` or `Football Fan`).
2.  **`Matches` Table:** Catalogs tournament events, baseline ticket inventory pricing, and match statuses.
3.  **`Bookings` Table:** Transactional table recording individual ticket purchases by linking users to matches.

---

## 🚀 How to Use This Repository

1.  Clone the repository to your local machine.
2.  Open the `QUERY.sql` file in VS Code or your preferred database IDE.
3.  Execute the table creation scripts followed by the data seeding block to populate sample datasets.
4.  Run the standard queries (Query 1 to Query 7) to test structural integrity and output results.

### Core SQL Concepts Demonstrated:
*   Pattern Matching (`LIKE`, `ILIKE`)
*   Null Handling (`IS NULL`, `COALESCE`)
*   Table Joins (`INNER JOIN`, `LEFT JOIN`)
*   Advanced Aggregations & Subqueries (`MAX`, `AVG`, Subqueries in `WHERE` clause)
*   Pagination and Offsets (`ORDER BY`, `LIMIT`)

---

## 🎓 Academic Info
*   **Course Assignment:** Football Ticket Booking System
*   **Submission Date:** June 2026

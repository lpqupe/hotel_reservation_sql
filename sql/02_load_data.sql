-- ============================================================
-- Load the CSV into the bookings table (SQLite CLI)
-- Run from the repo root:
--   sqlite3 data/hotel.db
--   .read sql/01_schema.sql
--   .read sql/02_load_data.sql
-- ============================================================

.mode csv
.import --skip 1 data/hospitality_bookings.csv bookings

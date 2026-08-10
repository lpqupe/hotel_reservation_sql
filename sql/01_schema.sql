-- ============================================================
-- Hotel Reservation Analysis — Schema
-- Target: SQLite (portable to PostgreSQL/MySQL with minor tweaks)
-- ============================================================

DROP TABLE IF EXISTS bookings;

CREATE TABLE bookings (
    avg_room_rate           REAL,       -- rate charged for the booking (USD)
    reservation_id          TEXT PRIMARY KEY,
    check_in_date           DATE,
    stay_duration            INTEGER,   -- nights
    adults                    INTEGER,
    children                  INTEGER,
    room_type                TEXT,      -- Single, Double, Queen, King, Suite, Executive Suite
    special_requests_flag    TEXT,      -- Yes / No
    booking_channel           TEXT,      -- Website, Phone App, Travel Agent, Call Center, Walk-in
    reservation_status        TEXT,      -- Completed, No-Show, Extended, Reduced
    advanced_booking          TEXT,      -- Yes / No — booked ahead of check-in vs same-day/walk-in
    property                   TEXT,      -- The Sankey, The Marimekko, The Chord
    txn_date                   DATE,      -- transaction/record date (mirrors check_in_date in source data)
    rate_type                  TEXT       -- Weekday / Weekend
);

-- Helpful indexes for the grouped queries in 02_analysis_queries.sql
CREATE INDEX idx_bookings_room_type ON bookings(room_type);
CREATE INDEX idx_bookings_channel   ON bookings(booking_channel);
CREATE INDEX idx_bookings_property  ON bookings(property);
CREATE INDEX idx_bookings_status    ON bookings(reservation_status);

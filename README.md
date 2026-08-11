# Hotel Reservation Analysis (SQL + Excel)

Analysis of 50,000 hotel bookings across three properties (The Sankey, The Marimekko, The Chord), looking at room-type popularity, booking-channel effectiveness, pricing patterns, and reservation outcomes.

The project has two parallel implementations of the same analysis:

- **SQL** (`/sql`) — the raw dataset loaded into a relational table, queried with SQL to answer each business question.
- **Excel** (`/excel`) — the original PivotTable/PivotChart dashboard the analysis was first built in.

Every SQL query result below was checked against the Excel pivot output and matches exactly.

## Repo structure

```
├── data/
│   └── hospitality_bookings.csv   # 50,000-row raw dataset
├── sql/
│   ├── 01_schema.sql              # table + index definitions
│   ├── 02_load_data.sql           # CSV import (SQLite CLI)
│   └── 03_analysis_queries.sql    # 10 documented analysis queries
├── excel/
│   └── hotel_dashboard.xlsx       # original pivot-table dashboard (see note below)
└── docs/
    └── findings.md                # write-up of results
```

## Dataset

Each row is one reservation, with these columns:

| Column | Description |
|---|---|
| `avg_room_rate` | Rate charged, USD |
| `reservation_id` | Unique booking ID |
| `check_in_date` | Check-in date |
| `stay_duration` | Nights booked |
| `adults` / `children` | Party size |
| `room_type` | Single, Double, Queen, King, Suite, Executive Suite |
| `special_requests_flag` | Yes/No |
| `booking_channel` | Website, Phone App, Travel Agent, Call Center, Walk-in |
| `reservation_status` | Completed, No-Show, Extended, Reduced |
| `advanced_booking` | Booked ahead of check-in (Yes) vs. same-day/walk-in (No) |
| `property` | The Sankey, The Marimekko, The Chord |
| `rate_type` | Weekday / Weekend |

## How to run the SQL

```bash
cd sql
sqlite3 ../data/hotel.db
.read 01_schema.sql
.read 02_load_data.sql
.read 03_analysis_queries.sql
```

(Works with SQLite out of the box; port to PostgreSQL/MySQL by adjusting the `CREATE TABLE` types and swapping the `.import` step for `COPY`/`LOAD DATA`.)

## Key findings

See [`docs/findings.md`](docs/findings.md) for the full write-up. Headline numbers:

- **Double** rooms are the most booked (12,936 reservations); **Executive Suite** the least (4,240).
- **Phone App** is the most effective completed-booking channel (13,848), ahead of Travel Agent and Website.
- **The Sankey** drives the majority of both volume (27,400 bookings) and revenue.
- Bookings made in advance complete at a marginally higher rate (90.2%) than same-day/walk-in bookings (89.5%).
- Weekend rates run about **$17.78 higher** than weekday rates on average ($159.81 vs. $142.03).

## Why both SQL and Excel

The dashboard was originally built with Excel PivotTables. This repo adds a SQL implementation of the same analysis to show the underlying logic explicitly and make it portable to any relational database — the Excel file remains as the original visual/interactive artifact.

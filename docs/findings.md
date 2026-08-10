# Findings

All figures below come from `sql/03_analysis_queries.sql` run against `data/hotel.db`, and were cross-checked against the original Excel PivotTables in `excel/hotel_dashboard.xlsx`.

## 1. Room type popularity

| Room type | Reservations |
|---|---|
| Double | 12,936 |
| Single | 10,764 |
| Queen | 8,872 |
| Suite | 6,623 |
| King | 6,565 |
| Executive Suite | 4,240 |

Double rooms are booked almost 3x as often as Executive Suites — likely the standard choice for couples/small groups, while Executive Suites serve a smaller premium segment.

## 2. Booking channel effectiveness (completed reservations)

| Channel | Completed bookings |
|---|---|
| Phone App | 13,848 |
| Travel Agent | 10,488 |
| Website | 10,379 |
| Call Center | 6,920 |
| Walk-in | 3,400 |

Phone App leads by a wide margin, suggesting mobile is the primary conversion channel worth further investment.

## 3. Property performance

| Property | Reservations | Total rate sum | Avg rate |
|---|---|---|---|
| The Sankey | 27,400 | $5,064,604.53 | $184.84 |
| The Marimekko | 13,666 | $1,505,363.53 | $110.15 |
| The Chord | 8,934 | $787,389.15 | $88.13 |

The Sankey is both the highest-volume and highest average-rate property — it's carrying most of the portfolio's revenue.

## 4. Reservation outcomes

| Status | Count | % of total |
|---|---|---|
| Completed | 45,035 | 90.07% |
| No-Show | 3,550 | 7.10% |
| Extended | 953 | 1.91% |
| Reduced | 462 | 0.92% |

## 5. Advanced booking vs. completion rate

| Booked in advance? | Total | Completed | Completion rate |
|---|---|---|---|
| Yes | 42,074 | 37,945 | 90.19% |
| No | 7,926 | 7,090 | 89.45% |

Advance bookings complete at a slightly higher rate, but the gap (0.74 points) is small — advance booking isn't a strong predictor of follow-through on its own.

## 6. Pricing

- Average room rate across all bookings: **$147.15** (range: $71.10–$288.55)
- **Weekend avg: $159.81** vs. **Weekday avg: $142.03** — a $17.78 (12.5%) weekend premium.

## 7. Party size & stay patterns

- Average stay length is similar regardless of whether special requests were flagged (~7.5 nights either way), so special requests don't appear to correlate with longer stays.
- Average party size is fairly consistent across room types (~5 people including children), suggesting room type choice is driven more by budget/preference than by group size.

## Suggested next steps

- Segment advance-booking completion rate by channel — the small overall gap may hide a bigger effect within specific channels.
- Build a monthly/seasonal trend view (query 10 in `03_analysis_queries.sql`) to check for seasonality in demand.
- Investigate why The Chord underperforms on both volume and rate relative to the other two properties.

# Ola Ride Analytics | SQL & Power BI

A data analytics portfolio project exploring ride bookings, vehicle performance, revenue, cancellations, payment methods, and customer/driver ratings.

## Project overview

- **Tools:** MySQL, Power BI, Excel
- **Dataset:** 100,000-row ride-booking dataset, as documented for this project
- **Dashboard sections:** Overall, Vehicle Type, Revenue, Cancellation, Ratings
- **SQL:** Basic business questions and advanced analysis using aggregations, CTEs, and window functions

## Business questions

- What percentage of bookings are successful, cancelled, or incomplete?
- Which vehicle types have the highest booking value and average ride distance?
- What are the most common customer and driver cancellation reasons?
- Which payment methods are used most often?
- How do customer and driver ratings vary by vehicle type?
- How do booking values change month over month?
- Which customers have the highest booking activity or booking value?

## Project files

| File | Purpose |
|---|---|
| `ola_ride_analysis.sql` | SQL analysis queries |
| `Ola Dashboard.pbix` | Power BI dashboard |
| `Bookings-100000-Rows.xlsx` | Source dataset, subject to its sharing permissions |

## Dashboard screenshots

### Overall
![Overall dashboard](https://github.com/user-attachments/assets/1d7d0799-11bc-4245-96c2-efdebf7aa6f4)

### Vehicle Type
![Vehicle Type dashboard](https://github.com/user-attachments/assets/4a21c5b6-f482-422f-b2eb-c1154036f89f)

### Revenue
![Revenue dashboard](https://github.com/user-attachments/assets/523ddaf2-867b-4096-a991-cfc4fdeb5b7a)

### Cancellation
![Cancellation dashboard](https://github.com/user-attachments/assets/66c65443-c5ab-45b9-9802-f36f4533f363)

### Ratings
![Ratings dashboard](https://github.com/user-attachments/assets/f60063c7-a102-4526-b953-329c3554d1ad)

## How to run

1. Download the source workbook and import it into MySQL.
2. Confirm the database/table name and column names match the SQL script.
3. Run the SQL sections in order; inspect the output of each query.
4. Open the Power BI file and configure its data source if needed.
5. Compare the main KPI totals between SQL and Power BI.

## Data quality and interpretation notes

- Standardize missing-value representations such as SQL `NULL`, blank strings, and text values like `'null'` before counting cancellation reasons.
- Keep customer cancellations, driver cancellations, and all cancelled bookings as distinct measures.
- State the denominator used for each rate, and exclude invalid or missing ratings from averages.
- Validate query outputs against the actual source workbook before reporting findings.

## Skills demonstrated

SQL filtering and aggregation, views, CTEs, window functions, KPI analysis, data validation, and Power BI dashboard development.

## Author

Swapnil Rathod

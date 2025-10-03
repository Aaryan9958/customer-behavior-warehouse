# Customer Analytics Data Warehouse (CIS 467 Final Project)

This repository contains a customer‑centric data warehouse, analytical SQL, and Tableau assets built on the **Sakila** sample database to analyze rental behavior, spending patterns, and store‑level activity.

> Course: CIS 467 — Data Management, Warehousing, and Visualization (Spring A, 2025)  
> Team: Group 3C — Jonathan Chen, Martin Sha, Matthew Irons, Aryan Bansal, Omkarsinh Rana

---

## 📦 Repository Structure

```
.
├── data/                      # CSV extracts used for analysis & viz
├── docs/                      # Final write‑up and any supporting docs
├── images/                    # (Optional) export screenshots here
├── sql/
│   ├── 01_create_dw.sql       # CREATE VIEW/TABLE for the DW
│   └── 02_queries.sql         # 8 analytical queries on the DW
├── tableau/
│   ├── CIS_467_final_group_project.twb
│   └── CIS_467_final_group_project.twbx
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🧠 Project Overview

The data warehouse provides a **single, customer‑level view** of rentals and payments, enriched with geography and preference signals. Core KPIs include **total rentals, total/avg spend, rental duration, favorite category, most rented movie**, and **home‑store loyalty**. These features enable targeted marketing, inventory planning, and retention programs.

**Subject area:** customers (DW + queries + viz are aligned to the same topic).

---

## 🏗️ Data Warehouse Design

**Grain:** one row per customer.  
**Sources (joins ≥ 6 Sakila tables):** `customer`, `address`, `city`, `country`, `rental`, `payment`, `inventory`, `film`, `film_category`, `category` (via subqueries).  
**Key measures & attributes:**
- `total_rentals`, `total_spent`, `avg_spent_per_rental`, `max_spend_per_rental`, `min_spend_per_rental`
- `average_rental_duration` (days)
- `favorite_category`, `most_rented_movie`
- `store_id`, `city`, `country`, `rentals_in_home_store`
- `last_rental_date`, `customer_active`

See `sql/01_create_dw.sql` for the exact DDL/DML used to build the DW.

---

## 🔎 Analytical SQL (8 queries)

The file `sql/02_queries.sql` includes:
1. **Top countries** by total rentals and avg spend per rental  
2. **Top customers** by total spend  
3. **Most popular categories** by store  
4. **Avg & total spend per country**  
5. **City‑level revenue analysis**  
6. **Avg rental duration** per country  
7. **Home‑store loyalty ratio** per customer  
8. **Top single‑transaction spend** per customer

Each query supports actionable decisions (inventory, pricing, retention, and localization).

---

## 📊 Tableau Visualizations

The workbook (`tableau/…twb(x)`) contains five visuals + a dashboard:
- **Customer Spending Distribution** (histogram)
- **Top 10 Customers by Spend** (bar)
- **Retention Rate by Country** (map)
- **Average Rental Duration by Country** (treemap)
- **Most Popular Categories** (bar)
- **Combined Dashboard** for exec review

> Tip: Export PNGs of each sheet and place them in `/images` for GitHub preview.

---

## 🗂️ Data Files

CSV extracts are under `/data`. You can regenerate them by running the SQL in `sql/01_create_dw.sql` and exporting from MySQL (or use the included CSVs directly for Tableau).

- `customer_warehouse_LATEST_VERSION.csv` — primary DW export
- `customer_spending.csv`, `top_customers.csv`, `retention_rate.csv`, `rental_duration.csv`, `popular_categories.csv`, `origin.csv` — convenience extracts for viz

---

## ▶️ Reproduce Locally

1. **Create Sakila DB** (run `sakila-schema.sql` then `sakila-data.sql` from MySQL docs).  
2. **Build the DW**  
   ```sql
   -- in MySQL
   SOURCE sql/01_create_dw.sql;
   ```
3. **Run analyses**  
   ```sql
   SOURCE sql/02_queries.sql;
   ```
4. **Export** `customer_warehouse_LATEST_VERSION` to CSV and open the Tableau workbook. If needed, **replace data source** to your CSV copy.

---

## 🚀 Publish to GitHub

1. Create an empty repo on GitHub (no README).  
2. In a terminal:
   ```bash
   cd path/to/cis467-customer-analytics-dw
   git init
   git add .
   git commit -m "Initial commit: DW, queries, Tableau, docs"
   git branch -M main
   git remote add origin https://github.com/<your-user>/<your-repo>.git
   git push -u origin main
   ```

Alternatively, zip and upload via GitHub’s web UI.

---

## 👥 Team

- Jonathan Chen  
- Martin Sha  
- Matthew Irons  
- Aryan Bansal  
- Omkarsinh Rana

---

## 📄 License

MIT — see `LICENSE`.

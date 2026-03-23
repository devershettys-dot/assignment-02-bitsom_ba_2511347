# ETL Notes — Retail Data Warehouse

## ETL Decisions

### Decision 1: Date Format Standardisation
**Problem:** The raw CSV contained dates in three different formats:
- `DD/MM/YYYY` (e.g. 29/08/2023)
- `DD-MM-YYYY` (e.g. 12-12-2023)
- `YYYY-MM-DD` (e.g. 2023-02-05)

This inconsistency would make date-based queries unreliable, as the database would not be able to sort or compare dates correctly.

**Resolution:** All dates were standardised to the ISO format `YYYY-MM-DD` before loading into `dim_date`. This ensures correct chronological ordering and consistent behaviour in month and quarter calculations.

---

### Decision 2: Category Casing Standardisation
**Problem:** The `category` column in the raw CSV used inconsistent capitalisation. For example, `electronics` and `Electronics` appeared as separate values, which would cause them to be counted as two different categories in GROUP BY queries, splitting the data incorrectly.

**Resolution:** All category values were standardised to Title Case (e.g. `Electronics`, `Clothing`, `Groceries`) before loading into `dim_product`. This ensures all products in the same category are grouped correctly in analytical queries.

---

### Decision 3: Inconsistent Category Naming
**Problem:** The Groceries category appeared under two different names in the raw CSV — `Grocery` and `Groceries`. These refer to the same product category but would be treated as separate groups in any GROUP BY query, understating the true revenue for that category.

**Resolution:** Both values were merged into a single standardised name `Groceries` during the ETL process before loading into `dim_product`. This ensures accurate revenue totals when analysing the Groceries category.
# DBT SQL ETL Project – Medallion Architecture (BigQuery)

This project showcases a complete ELT pipeline using **DBT** and **Google BigQuery**, following the **Medallion architecture** — transforming raw data (Bronze) into clean datasets (Silver) and final analytics-ready tables (Gold).

---

##  Tools & Technologies

- **DBT Core**
- **Google BigQuery**
- **SQL (Standard SQL)**
- **Medallion Architecture**
- **YAML configuration**
- **DBT Sources, Seeds, Models, Tests**

---

## Architecture Flow

This project follows the **Medallion Architecture**, a layered data modeling strategy that separates the ETL process into clearly defined stages:

### 🟫 Bronze Layer – Raw Ingestion
- Python Script is used to push raw data into bronze layer
- Represents raw data as ingested from source (e.g., CSVs, APIs, or external databases)
- No transformations — only basic loading and type inference
- Used for auditing, backup, or rollback if needed

### 🟪 Silver Layer – Cleaned & Enriched Data
- Applies cleaning logic: renaming columns, standardizing formats, handling nulls
- Joins with dimension/reference tables
- Filters duplicates or invalid records
- Becomes the "single source of truth" for analytics

### 🟨 Gold Layer – Business-Ready Tables
- Performs final aggregations, metrics, and KPIs (e.g., revenue by region, customer LTV)
- Data is ready for dashboards and BI tools
- Structured to support fast querying and reporting use cases

### Path for Queries
Project/
├── models/
│ ├── bronze/
│ ├── silver/
│ ├── gold/
│ └── gold_view/



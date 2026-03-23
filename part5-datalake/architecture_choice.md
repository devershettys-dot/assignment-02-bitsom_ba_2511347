# Part 5 — Data Lakes & DuckDB

## Architecture Recommendation

For a fast-growing food delivery startup that collects GPS location logs, customer text reviews, payment transactions, and restaurant menu images, I would recommend a **Data Lakehouse** architecture.

A Data Lakehouse combines the flexibility of a Data Lake with the structure and query performance of a Data Warehouse, making it the ideal fit for this use case. Here are three specific reasons:

**1. Handles All Data Types in One Place**
The startup collects highly diverse data — structured data (payment transactions), semi-structured data (customer text reviews), and unstructured data (GPS logs, menu images). A traditional Data Warehouse only handles structured/tabular data well and would struggle with images and raw GPS streams. A Data Lake alone can store all of these, but makes it hard to run reliable analytics on top. A Data Lakehouse handles all formats natively while still supporting SQL-based querying over structured data like transactions.

**2. Supports Both Real-Time and Batch Workloads**
GPS location logs are generated continuously and need near-real-time processing for delivery tracking. Payment transactions need reliable batch reporting for finance. A Data Lakehouse (e.g., built on Delta Lake or Apache Iceberg) supports both streaming ingestion and batch analytics on the same storage layer, eliminating the need to maintain two separate pipelines.

**3. Cost-Effective Scalability with ACID Guarantees**
As the startup grows, data volume will explode. A pure Data Warehouse becomes very expensive to scale. A Data Lakehouse stores data cheaply on object storage (like S3 or GCS) while adding ACID transaction support and schema enforcement on top — ensuring payment data integrity without the high cost of a full warehouse solution.

For these reasons, a Data Lakehouse strikes the best balance between flexibility, performance, and cost for this startup's mixed and rapidly growing data needs.

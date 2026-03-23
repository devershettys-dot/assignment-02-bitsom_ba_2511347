# Part 6 — Capstone Architecture Design

## Storage Systems

The architecture uses four storage systems, each chosen to match a specific goal.

**Goal 1 — Stream and store real-time ICU vitals:**
Apache Kafka is used as the ingestion queue to absorb the continuous high-frequency stream from ICU monitoring devices without data loss. The data is then persisted in **TimescaleDB**, a time-series database built on PostgreSQL. TimescaleDB is ideal here because it is optimised for time-stamped data, supports fast range queries (e.g. "show vitals from the last 2 hours"), and handles high write throughput efficiently.

**Goal 2 — Predict patient readmission risk:**
Historical treatment data is stored in **PostgreSQL** (OLTP) for structured patient records, and a **Data Lake** (e.g. AWS S3 or Azure Data Lake) holds the broader raw historical dataset used to train the ML model. The Data Lake is chosen because it can store data in any format (structured, semi-structured) at low cost, and ML training pipelines can read directly from it without transformation overhead.

**Goal 3 — Allow doctors to query patient history in plain English:**
The LLM / NLP layer sits on top of PostgreSQL and the Data Lake, translating natural language questions into SQL or semantic search queries. No separate storage is needed here — the interface layer retrieves from existing stores.

**Goal 4 — Generate monthly management reports:**
A **Data Warehouse** (e.g. Amazon Redshift or Google BigQuery) serves the reporting layer. Data is batch-loaded nightly from PostgreSQL and the Data Lake via an ETL pipeline. The warehouse is optimised for OLAP-style analytical queries — aggregations, groupings, and multi-dimensional breakdowns — which are exactly what monthly management reports require.

---

## OLTP vs OLAP Boundary

The boundary between the transactional and analytical systems sits between the Storage layer and the AI/Analytics layer.

**OLTP side (left of the boundary):**
- ICU device ingestion via Kafka → TimescaleDB
- Patient records ingestion via ETL → PostgreSQL

These systems handle live, operational data. Every ICU reading, every patient update, every admission record is written here in real time. These writes are frequent, small, and need to be fast and reliable — the hallmark of OLTP.

**OLAP side (right of the boundary):**
- The Data Lake stores raw and historical data for ML training
- The Data Warehouse (Redshift/BigQuery) serves analytical queries for monthly reports

The OLAP side is read-heavy, query-intensive, and deals with large aggregations over historical data. It does not serve live transactions. Data moves from OLTP to OLAP via nightly batch ETL jobs, which is the classic Lambda Architecture pattern — operational systems feed the analytical systems on a schedule.

---

## Trade-offs

**Trade-off: Data freshness vs query performance in the reporting layer**

The biggest trade-off in this design is the use of nightly batch ETL to populate the Data Warehouse. This means that monthly management reports are always based on data that is up to 24 hours old. For most reporting needs (bed occupancy trends, monthly cost summaries) this is acceptable — but if hospital management needs intraday dashboards (e.g. current bed availability), this design falls short.

**Mitigation strategy:**
The trade-off can be mitigated by introducing a **Lambda Architecture hybrid** approach: keep the nightly batch ETL for the deep historical reports, but add a lightweight **real-time aggregation layer** (e.g. Apache Flink or Kafka Streams) that computes running daily totals and writes them to a fast read store like Redis or a materialised view in TimescaleDB. Dashboards requiring near-real-time data query this hot layer, while full historical reports continue to use the Data Warehouse. This avoids over-engineering the warehouse for real-time workloads while still meeting both freshness requirements.

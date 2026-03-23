## Anomaly Analysis

Anomalies (data inconsistencies) arise because `orders_flat.csv` stores customer, product, and sales-rep information repeatedly inside every order row. Three classic anomaly types are demonstrated below.

### Insert Anomaly

**Definition:** You cannot record certain facts without also inserting an unrelated, possibly fictitious, record.

**Example from the dataset:**

Suppose a new product **P009 – Wireless Keyboard** at ₹1,500 is added to the catalogue. In the flat table there is nowhere to store `(P009, Wireless Keyboard, Electronics, 1500)` until at least one order is placed for it. The product simply cannot exist in the database without an accompanying order row — forcing either a dummy/fake order or loss of the information.

Similarly, if a new sales representative **SR04 – Meena Shah** joins the company, her details (`SR04, Meena Shah, meena@corp.com`) cannot be stored until she handles her first order.


### Update Anomaly

**Definition:** Changing one real-world fact requires updating many rows; missing even one row leaves the data in an inconsistent state.

**Example from the dataset:**

The address for the **Mumbai HQ** office appears in dozens of rows as:
`"Mumbai HQ, Nariman Point, Mumbai - 400021"`

However, in several later rows (e.g., ORD1170, ORD1172, ORD1173, ORD1176, ORD1177, ORD1180, ORD1181, ORD1182, ORD1183, ORD1184) it is stored as the abbreviated form:
`"Mumbai HQ, Nariman Pt, Mumbai - 400021"`

This is a direct result of the update anomaly — when the address string was typed again (or partially corrected), not all rows were updated consistently. If the office address genuinely changes, every single row for SR01 (Deepak Joshi) and any other rep at that office must be updated. One missed row creates a contradiction in the data.


### Delete Anomaly

**Definition:** Deleting a record to remove one piece of information unintentionally destroys other, unrelated information.

**Example from the dataset:**

Customer **C006 – Neha Gupta** (`neha@gmail.com`, Delhi) is the only customer who has placed orders for **P001 – Laptop** at ₹55,000 in rows ORD1061, ORD1109, and ORD1149. If business rules required purging all of Neha Gupta's orders (e.g., she requests account deletion), and she happened to be the *only* customer who ordered a particular product in a given period, deleting those rows would also erase all stored knowledge about that product's price, category, and name — information that has nothing to do with her account.

More starkly: if **ORD1093** (the only order by C007 – Arjun Nair for P006 – Standing Desk at ₹22,000) were deleted, the fact that Arjun Nair ever existed as a customer is lost, along with any record of that particular product combination — solely because the data lives in a single flat table.

## Normalization Justification

A manager might argue that keeping everything in one flat table is simpler and that normalization is unnecessary complexity. The `orders_flat.csv` dataset demonstrates clearly why that argument fails in practice.

Consider what actually happens in the flat table. The name, email, and city of customer **Priya Sharma (C002)** are repeated across at least 15 order rows. The product details for **Laptop (P001)** — its name, category, and price of ₹55,000 — are duplicated in roughly 30 rows. Sales representative **Deepak Joshi's** email and office address appear in well over 50 rows. Every one of these repetitions is a liability, not a convenience.

The update anomaly already visible in the data proves the point. The Mumbai HQ office address exists in two slightly different forms across the dataset — `"Nariman Point"` in older rows and `"Nariman Pt"` in several newer ones. This is not a theoretical risk; it is an actual inconsistency already present. In a normalized schema, the office address lives in exactly one row of a `sales_reps` or `offices` table. Correcting it takes a single `UPDATE`. In the flat table, a developer must find and fix every affected row — and as the data shows, that process is already failing.

The insert and delete anomalies are equally damaging. A new product cannot be catalogued until someone places an order for it, making inventory management impossible. Deleting a customer's orders risks erasing the only stored record of a product's price or a sales rep's contact details — information that should outlive any individual order.

Normalization to 3NF separates these concerns into dedicated tables: `customers`, `products`, `sales_reps`, and `orders`. Each fact is stored exactly once, referenced everywhere else by a key. The resulting schema is not over-engineering — it is the minimum structure required to keep data trustworthy. The "simplicity" of a flat file is an illusion that dissolves the moment any real-world change occurs: a price update, a rep's email change, or a customer deletion. Normalization trades superficial simplicity for genuine reliability.

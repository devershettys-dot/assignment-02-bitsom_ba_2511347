
-- Dimension Tables

CREATE TABLE IF NOT EXISTS dim_date (
    date_key    INTEGER PRIMARY KEY,
    full_date   DATE        NOT NULL,
    year        INTEGER     NOT NULL,
    month       INTEGER     NOT NULL,
    month_name  VARCHAR(10) NOT NULL,
    quarter     INTEGER     NOT NULL,
    day         INTEGER     NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_store (
    store_key   INTEGER PRIMARY KEY,
    store_name  VARCHAR(50) NOT NULL,
    city        VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_product (
    product_key  INTEGER PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category     VARCHAR(50) NOT NULL,
    unit_price   REAL        NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_sales (
    sale_id       INTEGER PRIMARY KEY,
    date_key      INTEGER NOT NULL,
    store_key     INTEGER NOT NULL,
    product_key   INTEGER NOT NULL,
    units_sold    INTEGER NOT NULL,
    unit_price    REAL    NOT NULL,
    total_revenue REAL    NOT NULL,
    FOREIGN KEY (date_key)    REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key)   REFERENCES dim_store(store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- Inserts: dim_date
INSERT INTO dim_date VALUES (1,  '2023-08-29', 2023, 8,  'August',   3, 29);
INSERT INTO dim_date VALUES (2,  '2023-12-12', 2023, 12, 'December', 4, 12);
INSERT INTO dim_date VALUES (3,  '2023-02-05', 2023, 2,  'February', 1,  5);
INSERT INTO dim_date VALUES (4,  '2023-02-20', 2023, 2,  'February', 1, 20);
INSERT INTO dim_date VALUES (5,  '2023-01-15', 2023, 1,  'January',  1, 15);
INSERT INTO dim_date VALUES (6,  '2023-03-31', 2023, 3,  'March',    1, 31);
INSERT INTO dim_date VALUES (7,  '2023-08-09', 2023, 8,  'August',   3,  9);
INSERT INTO dim_date VALUES (8,  '2023-10-26', 2023, 10, 'October',  4, 26);
INSERT INTO dim_date VALUES (9,  '2023-12-08', 2023, 12, 'December', 4,  8);
INSERT INTO dim_date VALUES (10, '2023-08-15', 2023, 8,  'August',   3, 15);

-- Inserts: dim_store
INSERT INTO dim_store VALUES (1, 'Chennai Anna',   'Chennai');
INSERT INTO dim_store VALUES (2, 'Delhi South',    'Delhi');
INSERT INTO dim_store VALUES (3, 'Bangalore MG',   'Bangalore');
INSERT INTO dim_store VALUES (4, 'Pune FC Road',   'Pune');
INSERT INTO dim_store VALUES (5, 'Mumbai Central', 'Mumbai');

-- Inserts: dim_product
INSERT INTO dim_product VALUES (1,  'Speaker',    'Electronics', 49262.78);
INSERT INTO dim_product VALUES (2,  'Tablet',     'Electronics', 23226.12);
INSERT INTO dim_product VALUES (3,  'Phone',      'Electronics', 48703.39);
INSERT INTO dim_product VALUES (4,  'Smartwatch', 'Electronics', 58851.01);
INSERT INTO dim_product VALUES (5,  'Laptop',     'Electronics', 42343.15);
INSERT INTO dim_product VALUES (6,  'Headphones', 'Electronics', 39854.96);
INSERT INTO dim_product VALUES (7,  'Jacket',     'Clothing',    30187.24);
INSERT INTO dim_product VALUES (8,  'Jeans',      'Clothing',     2317.47);
INSERT INTO dim_product VALUES (9,  'Saree',      'Clothing',    35451.81);
INSERT INTO dim_product VALUES (10, 'Atta 10kg',  'Groceries',   52464.00);
INSERT INTO dim_product VALUES (11, 'Biscuits',   'Groceries',   27469.99);
INSERT INTO dim_product VALUES (12, 'Milk 1L',    'Groceries',   43374.39);

-- Inserts: fact_sales
INSERT INTO fact_sales VALUES (1,  1,  1, 1,  3,  49262.78, 147788.34);
INSERT INTO fact_sales VALUES (2,  2,  1, 2,  11, 23226.12, 255487.32);
INSERT INTO fact_sales VALUES (3,  3,  1, 3,  20, 48703.39, 974067.80);
INSERT INTO fact_sales VALUES (4,  4,  2, 2,  14, 23226.12, 325165.68);
INSERT INTO fact_sales VALUES (5,  5,  1, 4,  10, 58851.01, 588510.10);
INSERT INTO fact_sales VALUES (6,  7,  3, 10, 12, 52464.00, 629568.00);
INSERT INTO fact_sales VALUES (7,  6,  4, 4,  6,  58851.01, 353106.06);
INSERT INTO fact_sales VALUES (8,  8,  4, 8,  16,  2317.47,  37079.52);
INSERT INTO fact_sales VALUES (9,  9,  3, 11, 9,  27469.99, 247229.91);
INSERT INTO fact_sales VALUES (10, 10, 3, 4,  3,  58851.01, 176553.03);

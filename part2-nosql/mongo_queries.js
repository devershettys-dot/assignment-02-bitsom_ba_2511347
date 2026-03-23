const db = connect("mongodb://localhost:27017/ecommerce");
const products = db.getCollection("products");

// OP1: insertMany() - insert all 3 documents from sample_documents.json
products.insertMany([
  { "product_id": "EM005",
    "product_name": "Mobile",
    "category": "Electronics",
    "unit_price": 25000,
    "warranty": {
      "period_months": 24,
      "from": "Samsung"
    },
    "voltage": {
      "specs": "2500V-3500V"
    },
    "tags": ["student", "personal"]
  },
  { "product_id": "CL012",
  "product_name": "Men's Casual Jacket",
  "category": "Clothing",
  "unit_price": 2500,
  "brand": "Levi's",
  "attributes": {
    "material": "Cotton",
    "sizes_available": ["S", "M", "L", "XL"],
    "colors": ["Black", "Navy Blue", "Olive"],
    "gender": "Male"
  },
  "tags": ["casual", "winter", "outdoor"]
},

  {"product_id": "GR021",
  "product_name": "Whole Wheat Bread",
  "category": "Groceries",
  "unit_price": 45,
  "brand": "Britannia",
  "expiry_date": "2024-11-30",
  "nutritional_info": {
    "calories_per_100g": 265,
    "protein_g": 9,
    "carbohydrates_g": 49,
    "fat_g": 3.5,
    "fiber_g": 6
  },
  "storage": "Cool and dry place",
  "tags": ["healthy", "breakfast", "vegan"]}
]);

// OP2: find() - retrieve all Electronics products with price > 20000
products.find({ "category": "Electronics", "unit_price": { $gt: 20000 } });

// OP3: find() - retrieve all Groceries expiring before 2025-01-01
products.find({ "category": "Groceries", "expiry_date": { $lt: "2025-01-01" } });

// OP4: updateOne() - add a "discount_percent" field to a specific product
products.updateOne(
  { "product_id": "EM005" },
  { $set: { "discount_percent": 10 } }
);

// OP5: createIndex() - create an index on category field
// Reason: Queries frequently filter by "category" (as seen in OP2 and OP3).
// An index on this field allows MongoDB to locate matching documents directly
// instead of scanning the entire collection, significantly improving query speed.
products.createIndex({ "category": 1 });
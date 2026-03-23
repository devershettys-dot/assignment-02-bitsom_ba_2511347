## Vector DB Use Case

A traditional keyword-based database search would not suffice for a law firm searching 500-page contracts using plain English questions. Keyword search is purely literal — it looks for exact word matches. So if a lawyer asks "What are the termination clauses?", it would only find paragraphs containing the word "termination" and completely miss legally equivalent phrases like "dissolution of agreement", "exit conditions", or "either party may cancel", even though they mean the same thing. This makes keyword search unreliable and incomplete for legal documents.

A vector database solves this by understanding the meaning of text, not just the words. Here is how it would work in this system:

Every paragraph in every contract is converted into an embedding (a vector of numbers) and stored in the vector database. When a lawyer types a plain English question, that question is also converted into an embedding. The system finds paragraphs whose embeddings are mathematically closest to the query embedding — meaning they are semantically similar. The most relevant paragraphs are returned, regardless of the exact words used.

This approach handles synonyms, paraphrasing, and legal jargon naturally. It transforms contract search from a rigid word-matching exercise into an intelligent, meaning-aware retrieval system — making lawyers significantly more efficient and reducing the risk of missing critical clauses.

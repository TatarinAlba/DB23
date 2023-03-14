EXPLAIN ANALYZE SELECT * FROM customer WHERE name = 'Courtney Chandler';
-- Try to get name Courney Chandler from the database
CREATE INDEX idx_customer_name ON customer(name);
-- Create btree index
EXPLAIN ANALYZE SELECT * FROM customer WHERE name = 'Courtney Chandler';
-- Try again and see the difference
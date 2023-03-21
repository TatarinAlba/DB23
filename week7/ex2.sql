CREATE OR REPLACE FUNCTION retrievecustomers(start_of INTEGER, end_of INTEGER)
RETURNS TABLE (
    customer_id INTEGER,
    store_id SMALLINT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(50),
    address_id SMALLINT, 
    activebool BOOLEAN, 
    create_date DATE,          
    last_update TIMESTAMP,
    active INTEGER
)
AS 
$$
BEGIN 
    RETURN QUERY SELECT * FROM customer WHERE customer.address_id BETWEEN start_of AND end_of ORDER BY customer.address_id;
END; 
$$
LANGUAGE 'plpgsql';

SELECT * FROM retrievecustomers(20, 50);
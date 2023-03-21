CREATE OR REPLACE FUNCTION retrieve_need_addresses()
RETURNS TABLE (
    city_id SMALLINT,
    address VARCHAR(255)
)
AS 
$$
BEGIN 
    RETURN QUERY SELECT address.city_id, address.address FROM address WHERE address.city_id BETWEEN 400 AND 600 AND address.address LIKE '%11%';
END; 
$$
LANGUAGE 'plpgsql';

ALTER TABLE address ADD longitude REAL, ADD latitude REAL;
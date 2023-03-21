import psycopg2
import config
from geopy.geocoders import Nominatim

con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="WAS_PROVIDED_IN_A_FILE", host="127.0.0.1", port="5432")

print("Database opened successfully")
cur = con.cursor()
cur.callproc('retrieve_need_addresses')
rows = cur.fetchall()
geolocator = Nominatim(user_agent="my_app", timeout=5)
for row in rows:
    try:
        location = geolocator.geocode(row[1])
        loc = location.latitude, location.longitude
        
    except AttributeError as e:
        loc = (0.0, 0.0)
    finally:
        cur.execute(f"UPDATE address SET latitude={loc[0]}, longitude={loc[1]} WHERE address='{row[1]}'")
con.commit()
cur.close()
con.close()
import pandas as pd
import numpy as np
from sqlalchemy import create_engine, text
from tqdm import tqdm
tqdm.pandas()

from dotenv import load_dotenv
import os

# Import environment variables
load_dotenv()

df = pd.read_excel('Sample Stormwater Data Compiled with category.xlsx', sheet_name='Stormwater BMPs', header=1,
                   skiprows= lambda x: x in [2], converters={'HUC 8': str})
col_dict = {
            'City': 'city',
            'County': 'county',
            'Installation Date (Completed)': 'installation_date',
            'Cost ($)': 'cost',
            'Drainage area going into the BMP (ac)': 'practice_drainage_area',
            'For New Development or Retrofit': 'new_development_or_retrofit',
            'HUC 8': 'huc8',
            'BMP Category (See next sheet)':'bmp_category',
            'BMP Name': 'bmp_name'
}

# Removing unnecessary column 7 of current data
df = df[col_dict.keys()]
df.rename(columns=col_dict, inplace=True)
df['huc8'] = df['huc8'].str.strip()
# Replacing nan with None
df = df.where(pd.notnull(df), None)
df = df.replace({np.nan: None})


# Build the Postgres URL for SqlAlchemy
username = os.environ.get('DB_USER')
password = os.environ.get('DB_PASSWORD')
host = os.environ.get('HOST')
pg_url = "postgresql://" + username + ":" + password + "@" + host + ":5432/gltg-gi"

db = create_engine(pg_url)
conn = db.connect()

successful_queries = 0


def insert_practice(practice):
    global successful_queries
    # Extract all values from row
    city = practice['city']
    county = practice['county']
    installation_date = practice['installation_date']
    practice_cost = practice['cost']
    practice_drainage_area = practice['practice_drainage_area']
    new_development_or_retrofit = practice['new_development_or_retrofit']
    bmp_category = practice['bmp_category']
    bmp_name = practice['bmp_name']
    huc8 = practice['huc8']


    # Check necessary variables available
    if bmp_name and bmp_category:

        try:
            # Get the  practice type id
            practice_type_query = "SELECT * FROM practice_types WHERE practice_category_type_name = \'{}\' AND " \
                              "practice_category = \'{}\';".format(
                bmp_category, bmp_name)
            results = conn.execute(practice_type_query)
            practice_id = results.fetchone()[0]

            # Add practice into table
            practice_query = text("INSERT INTO practices(county, city, installation_date, practice_cost," \
                                  "practice_drainage_area, new_development_or_retrofit,type_id) "\
                                  "VALUES (:county, :city, :installation_date, :practice_cost, :practice_drainage_area, "
                                  ":new_development_or_retrofit, :practice_id) RETURNING practice_id;")
            practice_query_dict = {
                "city": city,
                "county": county,
                "installation_date": installation_date,
                "practice_cost": practice_cost,
                "practice_drainage_area": practice_drainage_area,
                "new_development_or_retrofit": new_development_or_retrofit,
                "practice_id": practice_id
            }
            results = conn.execute(practice_query, practice_query_dict)
            practice_id = results.fetchone()[0]

            # Add practice huc relation to table
            practice_huc_query = text("INSERT INTO huc_practice_relations(huc8_id,practice_id)  VALUES(:huc8_id,:practice_id);")
            practice_huc_query_dict = {"huc8_id": huc8, "practice_id": practice_id}
            results = conn.execute(practice_huc_query, practice_huc_query_dict)
            successful_queries += 1
        except Exception as e:
            print("Row data")
            print(practice)
            print("Error Message" + str(e))


df.progress_apply(insert_practice, axis=1)
print("Successful queries " + str(successful_queries))
conn.close()

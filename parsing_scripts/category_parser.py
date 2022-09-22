import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from dotenv import load_dotenv
import os

# Import environment variables
load_dotenv()


df = pd.read_excel('Sample Stormwater Data Compiled with category.xlsx', sheet_name='BMP List', header=1)
# Removing unnecessary column 7 of current data
df = df.iloc[: , :-1]
col_dict = {
            'Category':'practice_category',
            'Best Management Practice': 'practice_name',
            'Source': 'practice_source',
            'Definition': 'practice_definition',
            'Total Suspended Sediment Reduction (fraction)': 'sediment_reduction',
            'Total Nitrogen Reduction (fraction)': 'total_nitrogen_reduction',
            'Total Phosphorus Reduction (fraction)': 'total_phosphorus_reduction',
}
df.rename(columns=col_dict, inplace=True)

# Build the Postgres URL for SqlAlchemy
username = os.environ.get('DB_USER')
password = os.environ.get('DB_PASSWORD')
host = os.environ.get('HOST')
pg_url = "postgresql://" + username + ":" + password + "@" + host + ":5432/gltg-gi"


db = create_engine(pg_url)
conn = db.connect()

df.to_sql('practice_info', con=conn, if_exists='append',index=False)
conn = psycopg2.connect(pg_url)
conn.autocommit = True
# cursor = conn.cursor()
#
# sql1 = 'select * from practice_info;'
# cursor.execute(sql1)
# for i in cursor.fetchall():
#     print(i)
#
# # conn.commit()
conn.close()
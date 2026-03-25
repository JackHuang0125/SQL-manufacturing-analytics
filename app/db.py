from sqlalchemy import create_engine
import pandas as pd


DB_USER = 'postgres'
DB_PASSWORD = '850125'
DB_HOST = 'localhost'
DB_PORT = '7851'
DB_NAME = 'manufacturing_sql_project'

def get_engine():
    connection_url = (
        f'postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'
    )
    return create_engine(connection_url)

def run_query(sql: str) -> pd.DataFrame:
    engine = get_engine()
    with engine.connect() as conn:
        df = pd.read_sql(sql, conn)
        return df
        
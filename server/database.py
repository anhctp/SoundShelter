from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import mysql.connector
from dotenv import load_dotenv
import os

load_dotenv()

try:
    mysql_connection = mysql.connector.connect(
        user=os.getenv("DB_USERNAME"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        database=os.getenv("DB_NAME"),
    )
    print("Connected to MySQL successfully!")
except mysql.connector.Error as err:
    print(f"Error: {err}")

engine = create_engine(
    f"mysql+mysqlconnector://{ os.getenv('DB_USERNAME') }:{ os.getenv('DB_PASSWORD') }@{ os.getenv('DB_HOST') }/{ os.getenv('DB_NAME') }",
    echo=True,
)

# create a SessionLocal class
SessionLocal = sessionmaker(autocommit=False, autoflush=True, bind=engine)

# create a Base class
Base = declarative_base()


def getDatabase():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
from sqlalchemy import Column, Integer, String
from database import Base


class GenreModel(Base):
    __tablename__ = "genres"
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(20), unique=True)
    name = Column(String(50))

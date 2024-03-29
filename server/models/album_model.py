from sqlalchemy import Column, ForeignKey, Integer, String, DateTime
from database import Base


class AlbumModel(Base):
    __tablename__ = "albums"
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(20), unique=True)
    title = Column(String(100))
    release_date = Column(DateTime)
    artist = Column(String(100))
    genre_id = Column(Integer, ForeignKey("Genres.id"))
    image_file_path = Column(String(255))

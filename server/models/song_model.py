from sqlalchemy import Column, ForeignKey, Integer, String, Date
from database import Base


class SongModel(Base):
    __tablename__ = "songs"
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(20), unique=True)
    title = Column(String(100))
    artist = Column(String(100))
    audio_file_path = Column(String(255))
    image_file_path = Column(String(255))
    album_id = Column(Integer, ForeignKey("albums.id"), nullable=True)
    playlist_id = Column(Integer, ForeignKey("playlists.id"), nullable=True)
    release_date = Column(Date)
    views = Column(Integer, default=0)

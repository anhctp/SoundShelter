from sqlalchemy import Column, ForeignKey, Integer, String
from database import Base


class PlaylistModel(Base):
    __tablename__ = "playlists"
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(20), unique=True)
    name = Column(String(100))
    user_id = Column(Integer, ForeignKey("users.id"), nullable=True)
    image_file_path = Column(String(255))

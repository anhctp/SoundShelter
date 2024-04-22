from sqlalchemy import Column, ForeignKey, Integer, String, Float, DateTime, Text
import database
from database import Base
from sqlalchemy.orm import relationship


class CommentModel(Base):
    __tablename__ = "comments"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    song_id = Column(Integer, ForeignKey("songs.id"))
    content = Column(Text)
    time = Column(DateTime)
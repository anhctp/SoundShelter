from sqlalchemy import Column, ForeignKey, Integer, String, Date
from database import Base


class ScoreModel(Base):
    __tablename__ = "scores"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    song_id = Column(Integer, ForeignKey("songs.id"))
    score = Column(Integer, default=0)
    
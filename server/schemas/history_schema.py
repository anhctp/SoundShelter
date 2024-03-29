from pydantic import BaseModel
from datetime import datetime


class HistoryCreate(BaseModel):
    user_id: int
    song_id: int
    play_date: datetime

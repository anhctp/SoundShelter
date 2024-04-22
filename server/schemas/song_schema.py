from typing import Optional
from pydantic import BaseModel
from datetime import datetime


class SongCreate(BaseModel):
    code: str
    title: str
    artist: str
    audio_file_path: str
    image_file_path: str
    album_id: Optional[int] = None
    playlist_id: Optional[int] = None
    release_date: datetime
    views: int

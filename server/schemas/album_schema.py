from pydantic import BaseModel
from datetime import datetime


class AlbumCreate(BaseModel):
    title: str
    code: str
    image_file_path: str
    release_date: datetime
    artist: str
    genre_id: int

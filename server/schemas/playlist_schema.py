from pydantic import BaseModel
from datetime import datetime
from typing import Optional


class PlaylistCreate(BaseModel):
    name: str
    code: str
    image_file_path: str
    user_id: Optional[int] = None

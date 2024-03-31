from pydantic import BaseModel


class FavoriteCreate(BaseModel):
    user_id: int
    song_id: int

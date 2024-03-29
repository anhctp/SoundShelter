from pydantic import BaseModel


class GenreCreate(BaseModel):
    name: str
    code: str

from pydantic import BaseModel
from datetime import datetime
from typing import Optional


class Login(BaseModel):
    email: str
    password: str


class Register(Login):
    name: str

    class Config:
        from_attributes = True

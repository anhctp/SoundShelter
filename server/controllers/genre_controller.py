from fastapi import Depends, HTTPException
from models.user_model import UserModel
from models.genre_model import GenreModel
from schemas.genre_schema import GenreCreate
from database import get_database
from sqlalchemy.orm import Session


class GenreController:
    def create_genre(genre: GenreCreate, db: Session):
        db_genre = db.query(GenreModel).filter(
            GenreModel.code == genre.code).first()
        if not db_genre:
            db_genre = GenreModel(
                code=genre.code,
                name=genre.name,
            )
            db.add(db_genre)
            db.commit()
            db.refresh(db_genre)
        return db_genre

    def get_all_genre(db: Session):
        return db.query(GenreModel).all()

    def get_genre_by_id(genre_id: int, db: Session):
        return db.query(GenreModel).filter(GenreModel.id == genre_id).first()

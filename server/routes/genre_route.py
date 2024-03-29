from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.genre_controller import GenreController
from schemas.genre_schema import GenreCreate
from models.genre_model import GenreModel

router = APIRouter(
    tags=["Genres"],
    prefix="/genre",
    responses={404: {"description": "Not found"}},
)


@router.post("/create")
def create_genre(genre: GenreCreate, db: Session = Depends(get_database)):
    return GenreController.create_genre(genre=genre, db=db)


@router.get("/all")
def get_all_genre(db: Session = Depends(get_database)):
    return GenreController.get_all_genre(db=db)


@router.get("/{genre_id}")
def get_genre_by_id(genre_id: int, db: Session = Depends(get_database)):
    return GenreController.get_genre_by_id(genre_id=genre_id, db=db)
